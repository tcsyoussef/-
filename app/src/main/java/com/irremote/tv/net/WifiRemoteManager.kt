package com.irremote.tv.net

import android.util.Log
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

    override fun send(command: RemoteCommand): TransmitResult =
        session?.send(command) ?: TransmitResult.Failed("Connect to a TV in the Wi‑Fi panel first")

    override fun sendText(text: String): TransmitResult =
        session?.sendText(text) ?: TransmitResult.Failed("Connect to a TV in the Wi‑Fi panel first")

    fun disconnect() {
        session?.close()
        session = null
    }

    fun lastTv(): DiscoveredTv? = store.lastTv()

    /** Which platform answers at [ip]; null when no supported service is listening. */
    fun detect(ip: String): DiscoveredTv? = classify(ip, openPorts(ip))

    fun openPorts(ip: String): Set<Int> = allPorts().filterTo(LinkedHashSet()) { isPortOpen(ip, it, probeTimeoutMs) }

    fun allPorts(): List<Int> = listOf(
        ports.androidTvRemote, ports.androidTvPairing,
        ports.samsungWss, ports.samsungWs,
        ports.lgWs, ports.lgWss,
        ports.roku, ports.haierDiscover
    )

    fun classify(ip: String, open: Set<Int>): DiscoveredTv? {
        val protocol = when {
            ports.androidTvRemote in open || ports.androidTvPairing in open -> TvProtocol.ANDROID_TV
            ports.samsungWs in open || ports.samsungWss in open -> TvProtocol.SAMSUNG
            ports.lgWs in open || ports.lgWss in open -> TvProtocol.LG_WEBOS
            ports.roku in open -> TvProtocol.ROKU
            ports.haierDiscover in open -> TvProtocol.HAIER_VESTEL
            else -> return null
        }
        return DiscoveredTv(ip, protocol, friendlyName(ip, protocol) ?: protocol.displayName)
    }

    private fun friendlyName(ip: String, protocol: TvProtocol): String? = runCatching {
        when (protocol) {
            TvProtocol.SAMSUNG -> get("http://$ip:${ports.samsungWs}/api/v2/")
                ?.let { JSONObject(it).optJSONObject("device")?.optString("name") }
            TvProtocol.ROKU -> get("http://$ip:${ports.roku}/query/device-info")?.let {
                tag(it, "user-device-name") ?: tag(it, "friendly-device-name") ?: tag(it, "model-name")
            }
            TvProtocol.HAIER_VESTEL -> get("http://$ip:${ports.haierDiscover}/dd.xml")?.let { tag(it, "friendlyName") }
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
        return connect(tv, prompt)
    }

    /** Blocking; call off the main thread. */
    fun connect(tv: DiscoveredTv, prompt: PromptListener?): ConnectOutcome {
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
                    HaierSession(tv, HaierWifiClient(discoverPort = ports.haierDiscover)).also { it.open() }
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
        private val IPV4 = Regex("""^(25[0-5]|2[0-4]\d|1?\d?\d)(\.(25[0-5]|2[0-4]\d|1?\d?\d)){3}$""")
    }
}
