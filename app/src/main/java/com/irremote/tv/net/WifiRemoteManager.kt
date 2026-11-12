package com.irremote.tv.net

import android.util.Log
import com.irremote.tv.control.InputSource
import com.irremote.tv.control.TvApp
import com.irremote.tv.control.RemoteTarget
import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.net.androidtv.AndroidTvPairing
import com.irremote.tv.net.androidtv.AndroidTvSession
import com.irremote.tv.net.androidtv.ClientIdentity
import com.irremote.tv.net.haier.HaierSession
import com.irremote.tv.net.lg.WebOsSession
import com.irremote.tv.net.roku.RokuSession
import com.irremote.tv.net.samsung.SamsungSession
import com.irremote.tv.wifi.HaierWifiClient
import okhttp3.OkHttpClient
import okhttp3.Request
import org.json.JSONObject
import java.util.concurrent.ConcurrentHashMap
import java.util.concurrent.Executors

/**
 * Finds out which platform a TV runs (Android TV, Samsung, LG, Roku, Haier SmartCenter),
 * opens the matching LAN session and forwards remote keys / text to it.
 */
class WifiRemoteManager(
    private val store: PairingStore,
    private val identity: () -> ClientIdentity,
    private val ports: TvPorts = TvPorts(),
    private val http: OkHttpClient = TrustAll.okHttp(),
    private val clientName: String = "IR TV Remote",
    private val probeTimeoutMs: Int = 700
) : RemoteTarget {

    @Volatile
    var session: RemoteSession? = null
        private set

    val connectedTv: DiscoveredTv? get() = session?.tv

    override val isReady: Boolean get() = session?.isOpen == true
    override val supportsText: Boolean get() = session?.supportsText == true

    override fun send(command: RemoteCommand): TransmitResult = withRecovery { it.send(command) }

    override fun launchApp(app: TvApp): TransmitResult = withRecovery { it.launchApp(app) }

    override val inputKeyReliable: Boolean get() = session?.tv?.protocol != TvProtocol.ANDROID_TV

    @Volatile private var inputHelper: HaierSession? = null
    private val smartCenterAt = ConcurrentHashMap<String, Boolean>()

    /**
     * Haier TVs often answer both Android TV and SmartCenter. Google TV ignores Input sent over
     * the Android TV remote, but SmartCenter's Input key opens the TV's source menu.
     */
    override fun sendNativeInput(): TransmitResult? {
        val tv = session?.tv ?: return null
        if (tv.protocol == TvProtocol.HAIER_VESTEL) return null
        val helper = inputHelper?.takeIf { it.tv.ip == tv.ip && it.isOpen } ?: run {
            val available = smartCenterAt.getOrPut(tv.ip) {
                (listOf(ports.haierDiscover) + ports.haierCommand).any { isPortOpen(tv.ip, it, probeTimeoutMs) }
            }
            if (!available) return null
            runCatching {
                HaierSession(tv.copy(protocol = TvProtocol.HAIER_VESTEL), haierClient()).also { it.open(probeKey = false) }
            }.onFailure { Log.w(TAG, "SmartCenter Input channel unavailable at ${tv.ip}", it) }
                .getOrNull() ?: return null
        }
        inputHelper = helper
        return helper.send(RemoteCommand.INPUT)
    }

    private fun haierClient() = HaierWifiClient(
        discoverPort = ports.haierDiscover,
        commandPorts = ports.haierCommand.toIntArray()
    )

    override fun sendText(text: String): TransmitResult = withRecovery { it.sendText(text) }

    override fun inputSources(): List<InputSource> = session?.inputSources().orEmpty()

    override fun selectInput(source: InputSource): TransmitResult = withRecovery { it.selectInput(source) }

    /** Runs [action]; if the TV dropped the connection, reconnects silently and tries once more. */
    private fun withRecovery(action: (RemoteSession) -> TransmitResult): TransmitResult {
        val current = session ?: return TransmitResult.Failed(NOT_CONNECTED)
        val result = action(current)
        if (result !is TransmitResult.Failed || current.isOpen) return result
        val revived = reconnect(current.tv) ?: return result
        return action(revived)
    }

    @Synchronized
    private fun reconnect(tv: DiscoveredTv): RemoteSession? {
        session?.takeIf { it.isOpen && it.tv.ip == tv.ip }?.let { return it }
        return when (val outcome = connect(tv, null)) {
            is ConnectOutcome.Connected -> outcome.session
            is ConnectOutcome.NeedsPin -> {
                outcome.cancel()
                null
            }
            is ConnectOutcome.Failed -> null
        }
    }

    fun disconnect() {
        inputHelper?.close()
        inputHelper = null
        session?.close()
        session = null
    }

    fun lastTv(): DiscoveredTv? = store.lastTv()

    /** Which platform answers at [ip]; null when no supported service is listening. */
    fun detect(ip: String): DiscoveredTv? = classify(ip, openPorts(ip))

    fun openPorts(ip: String): Set<Int> {
        val ports = allPorts()
        val pool = Executors.newFixedThreadPool(ports.size)
        return try {
            val probes = ports.map { port -> port to pool.submit<Boolean> { isPortOpen(ip, port, probeTimeoutMs) } }
            probes.filterTo(ArrayList()) { (_, open) -> open.get() }.mapTo(LinkedHashSet()) { it.first }
        } finally {
            pool.shutdownNow()
        }
    }

    fun allPorts(): List<Int> = listOf(
        ports.androidTvRemote, ports.androidTvPairing,
        ports.samsungWss, ports.samsungWs,
        ports.lgWs, ports.lgWss,
        ports.roku, ports.haierDiscover
    ) + ports.haierCommand

    /** Every platform answering at an IP, best first. */
    fun candidates(open: Set<Int>): List<TvProtocol> = buildList {
        if (ports.androidTvRemote in open || ports.androidTvPairing in open) add(TvProtocol.ANDROID_TV)
        if (ports.samsungWs in open || ports.samsungWss in open) add(TvProtocol.SAMSUNG)
        if (ports.lgWs in open || ports.lgWss in open) add(TvProtocol.LG_WEBOS)
        if (ports.roku in open) add(TvProtocol.ROKU)
        if (ports.haierDiscover in open || ports.haierCommand.any { it in open }) add(TvProtocol.HAIER_VESTEL)
    }

    fun classify(ip: String, open: Set<Int>): DiscoveredTv? {
        val protocols = candidates(open).ifEmpty { return null }
        val name = protocols.firstNotNullOfOrNull { friendlyName(ip, it) } ?: protocols.first().displayName
        return DiscoveredTv(ip, protocols.first(), name, alternatives = protocols.drop(1))
    }

    private fun friendlyName(ip: String, protocol: TvProtocol): String? = runCatching {
        when (protocol) {
            TvProtocol.SAMSUNG -> get("http://$ip:${ports.samsungWs}/api/v2/")
                ?.let { JSONObject(it).optJSONObject("device")?.optString("name") }
            TvProtocol.ROKU -> get("http://$ip:${ports.roku}/query/device-info")?.let {
                tag(it, "user-device-name") ?: tag(it, "friendly-device-name") ?: tag(it, "model-name")
            }
            TvProtocol.HAIER_VESTEL -> get("http://$ip:${ports.haierDiscover}/dd.xml")?.let { tag(it, "friendlyName") }
            // Google TVs with Chromecast built-in report the name set on the TV
            TvProtocol.ANDROID_TV -> get("http://$ip:${ports.cast}/setup/eureka_info?params=name")
                ?.let { JSONObject(it).optString("name") }
            else -> null
        }
    }.getOrNull()?.takeIf { it.isNotBlank() }

    private fun get(url: String): String? =
        http.newCall(Request.Builder().url(url).build()).execute().use { if (it.isSuccessful) it.body?.string() else null }

    private fun tag(xml: String, name: String): String? =
        Regex("<$name>([^<]*)</$name>").find(xml)?.groupValues?.get(1)?.trim()

    /** Detects the platform at [ip] then connects. */
    fun connectIp(ip: String, prompt: PromptListener?): ConnectOutcome {
        val cleaned = ip.trim()
        if (!IPV4.matches(cleaned)) return ConnectOutcome.Failed("Enter a valid IPv4 address")
        val tv = detect(cleaned) ?: return ConnectOutcome.Failed(
            "No supported TV found at $cleaned. Check the TV is on, on the same Wi‑Fi, " +
                "and its remote/mobile-control setting is enabled."
        )
        return connect(tv, prompt, probeAgain = false)
    }

    /**
     * Connects to the TV saved last time. If it no longer answers at its old IP (the router gave
     * it a new one), [rescan] is used to find it again by name. Blocking.
     */
    fun connectSaved(prompt: PromptListener?, rescan: () -> List<DiscoveredTv>): ConnectOutcome {
        val last = lastTv() ?: return ConnectOutcome.Failed(NOT_CONNECTED)
        val first = connect(last, prompt)
        if (first !is ConnectOutcome.Failed) return first
        val found = rescan()
        val moved = found.firstOrNull { it.ip != last.ip && it.name == last.name }
            ?: found.singleOrNull()?.takeIf { it.ip != last.ip }
            ?: return first
        return connect(moved, prompt)
    }

    /**
     * Blocking; call off the main thread. Tries the TV's main platform first, then every other
     * platform answering at the same IP, so the user never has to pick a protocol.
     */
    fun connect(tv: DiscoveredTv, prompt: PromptListener?, probeAgain: Boolean = true): ConnectOutcome {
        val tried = LinkedHashSet<TvProtocol>()
        var failure: ConnectOutcome.Failed? = null
        fun attempt(protocols: List<TvProtocol>): ConnectOutcome? {
            for (protocol in protocols) {
                if (!tried.add(protocol)) continue
                val outcome = connectWith(tv.copy(protocol = protocol, alternatives = emptyList()), prompt)
                if (outcome !is ConnectOutcome.Failed) return outcome
                failure = outcome
            }
            return null
        }
        attempt(listOf(tv.protocol) + tv.alternatives)?.let { return it }
        // A saved TV only remembers one platform: look again for anything else at that IP
        if (probeAgain && tv.alternatives.isEmpty()) detect(tv.ip)?.let { fresh -> attempt(listOf(fresh.protocol) + fresh.alternatives)?.let { return it } }
        return failure ?: ConnectOutcome.Failed(NOT_CONNECTED)
    }

    private fun connectWith(tv: DiscoveredTv, prompt: PromptListener?): ConnectOutcome {
        disconnect()
        return try {
            when (tv.protocol) {
                TvProtocol.ANDROID_TV -> connectAndroidTv(tv)
                TvProtocol.SAMSUNG -> connected(SamsungSession(tv, store, http, ports.samsungWss, ports.samsungWs, clientName).also { it.open(prompt) })
                TvProtocol.LG_WEBOS -> connected(WebOsSession(tv, store, http, ports.lgWs, ports.lgWss).also { it.open(prompt) })
                TvProtocol.ROKU -> {
                    get("http://${tv.ip}:${ports.roku}/query/device-info")
                        ?: return ConnectOutcome.Failed("Roku at ${tv.ip} did not answer")
                    connected(RokuSession(tv, http, ports.roku))
                }
                TvProtocol.HAIER_VESTEL -> connected(
                    HaierSession(tv, haierClient()).also { it.open() }
                )
            }
        } catch (error: Exception) {
            Log.w(TAG, "Connect to ${tv.ip} failed", error)
            ConnectOutcome.Failed(error.message ?: "Connect failed")
        }
    }

    private fun connected(s: RemoteSession): ConnectOutcome {
        session = s
        store.setLastTv(s.tv)
        return ConnectOutcome.Connected(s)
    }

    private fun connectAndroidTv(tv: DiscoveredTv): ConnectOutcome {
        val id = identity()
        val atv = AndroidTvSession(tv, ports.androidTvRemote, id)
        try {
            atv.open()
            return connected(atv)
        } catch (needsPairing: NeedsPairingException) {
            Log.i(TAG, "Pairing needed: ${needsPairing.message}")
        }
        val pairing = AndroidTvPairing(tv.ip, ports.androidTvPairing, id, clientName)
        try {
            pairing.start()
        } catch (error: Exception) {
            pairing.close()
            return ConnectOutcome.Failed("Android TV pairing failed: ${error.message}")
        }
        return pinPrompt(tv, pairing, atv, null)
    }

    private fun pinPrompt(tv: DiscoveredTv, pairing: AndroidTvPairing, atv: AndroidTvSession, error: String?): ConnectOutcome =
        ConnectOutcome.NeedsPin(
            tv = tv,
            error = error,
            submit = { pin ->
                try {
                    pairing.finish(pin)
                    pairing.close()
                    atv.open()
                    connected(atv)
                } catch (wrongCode: IllegalArgumentException) {
                    pinPrompt(tv, pairing, atv, wrongCode.message ?: "Wrong code")
                } catch (failure: Exception) {
                    pairing.close()
                    ConnectOutcome.Failed("Android TV pairing failed: ${failure.message}")
                }
            },
            cancel = { pairing.close() }
        )

    companion object {
        private const val TAG = "WifiRemoteManager"
        private const val NOT_CONNECTED = "Connect to a TV first"
        private val IPV4 = Regex("""^(25[0-5]|2[0-4]\d|1?\d?\d)(\.(25[0-5]|2[0-4]\d|1?\d?\d)){3}$""")
    }
}
