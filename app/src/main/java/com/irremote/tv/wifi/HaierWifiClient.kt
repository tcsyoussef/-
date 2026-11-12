package com.irremote.tv.wifi

import android.util.Log
import com.irremote.tv.ir.IrPattern
import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.InetSocketAddress
import java.net.Socket
import java.net.URL
import java.util.concurrent.atomic.AtomicReference

/**
 * Functional Wi‑Fi control for Haier / Vestel SmartCenter TVs.
 *
 * Discovery: GET http://IP:56790/dd.xml
 * Commands: POST http://IP:{56789|56791}/apps/SmartCenter
 * Body: <?xml version='1.0' ?><remote><key code='N'/></remote>
 * Content-Type: text/plain; charset=ISO-8859-1
 */
class HaierWifiClient(
    private val discoverPort: Int = 56790,
    private val commandPorts: IntArray = COMMAND_PORTS
) {

    private val connected = AtomicReference<WifiTvDevice?>(null)

    val device: WifiTvDevice?
        get() = connected.get()

    val isConnected: Boolean
        get() = connected.get() != null

    fun connect(ip: String, timeoutMs: Int = 3500): Result<WifiTvDevice> {
        val cleaned = ip.trim()
        if (!IPV4.matches(cleaned)) {
            return Result.failure(IllegalArgumentException("Enter a valid IPv4 address"))
        }
        return try {
            val xml = getDdXml(cleaned, timeoutMs)
            val name = extractTag(xml, "friendlyName") ?: "Haier TV"
            val model = extractTag(xml, "modelName") ?: ""
            val commandPort = detectCommandPort(cleaned)
                ?: return Result.failure(
                    IllegalStateException(
                        "TV found on $cleaned:$discoverPort but command port ${commandPorts.joinToString("/")} is closed. Enable SmartCenter / network remote on the TV."
                    )
                )
            // Soft validation: confirm SmartCenter accepts a POST (Info 1018 is harmless).
            // Do NOT fall back to OK — that would click OK on the TV.
            val accepted = runCatching { postKey(cleaned, KEY_INFO, commandPort) }.getOrDefault(false)
            if (!accepted) {
                Log.w(TAG, "Info probe not accepted on :$commandPort — still connecting; first key may negotiate body")
            }
            val device = WifiTvDevice(
                ip = cleaned,
                name = name,
                model = model,
                portCommand = commandPort
            )
            connected.set(device)
            Log.i(TAG, "Connected $device (probeAccepted=$accepted)")
            Result.success(device)
        } catch (error: Exception) {
            connected.set(null)
            Result.failure(error)
        }
    }

    fun disconnect() {
        connected.set(null)
    }

    fun send(command: RemoteCommand): TransmitResult {
        val device = connected.get()
            ?: return TransmitResult.Failed("Not connected over Wi‑Fi. Scan/connect to your Haier TV first.")
        val code = HaierWifiKeyCodes.codeFor(command)
        return try {
            // Keepalive then send (required by some Vestel firmwares)
            runCatching { getDdXml(device.ip, 2000) }
            var ok = postKey(device.ip, code, device.portCommand)
            if (!ok) {
                // Try the alternate Vestel command port
                for (alt in commandPorts) {
                    if (alt == device.portCommand) continue
                    if (!isPortOpen(device.ip, alt, 500)) continue
                    if (postKey(device.ip, code, alt)) {
                        connected.set(device.copy(portCommand = alt))
                        ok = true
                        break
                    }
                }
            }
            if (!ok) {
                getDdXml(device.ip, 2000)
                ok = postKey(device.ip, code, connected.get()?.portCommand ?: device.portCommand)
            }
            if (!ok) {
                return TransmitResult.Failed("TV did not accept Wi‑Fi key $code (${command.label})")
            }
            val port = connected.get()?.portCommand ?: device.portCommand
            Log.i(TAG, "WiFi TX ${device.ip}:$port ${command.label} code=$code")
            TransmitResult.Sent(IrPattern(0, intArrayOf(1)), repeats = 1)
        } catch (error: Exception) {
            TransmitResult.Failed(error.message ?: "Wi‑Fi command failed")
        }
    }

    fun probe(ip: String, timeoutMs: Int = 900): WifiTvDevice? {
        return try {
            val xml = getDdXml(ip, timeoutMs)
            val commandPort = detectCommandPort(ip) ?: 56789
            WifiTvDevice(
                ip = ip,
                name = extractTag(xml, "friendlyName") ?: "Haier TV",
                model = extractTag(xml, "modelName") ?: "",
                portCommand = commandPort
            )
        } catch (_: Exception) {
            null
        }
    }

    fun detectCommandPort(ip: String): Int? {
        for (port in commandPorts) {
            if (isPortOpen(ip, port, 600)) return port
        }
        return null
    }

    fun isPortOpen(ip: String, port: Int, timeoutMs: Int = 400): Boolean {
        return try {
            Socket().use { socket ->
                socket.connect(InetSocketAddress(ip, port), timeoutMs)
                true
            }
        } catch (_: Exception) {
            false
        }
    }

    fun getDdXml(ip: String, timeoutMs: Int): String {
        val url = URL("http://$ip:$discoverPort/dd.xml")
        val connection = (url.openConnection() as HttpURLConnection).apply {
            requestMethod = "GET"
            connectTimeout = timeoutMs
            readTimeout = timeoutMs
            instanceFollowRedirects = true
            setRequestProperty("Connection", "Keep-Alive")
            setRequestProperty("User-Agent", "IRTVRemote/1.0")
        }
        val code = connection.responseCode
        val stream = if (code in 200..299) connection.inputStream else connection.errorStream
            ?: throw IllegalStateException("Discover HTTP $code")
        return stream.use { BufferedReader(InputStreamReader(it, Charsets.UTF_8)).readText() }
    }

    /**
     * @return true if TV accepted at least one request variant with HTTP 2xx
     */
    fun postKey(ip: String, keyCode: Int, port: Int): Boolean {
        val contentTypes = listOf(
            "text/plain; charset=ISO-8859-1",
            "text/plain; charset=utf-8",
            "application/xml",
            "text/xml"
        )
        var lastError: Exception? = null
        for (body in HaierWifiKeyCodes.requestBodies(keyCode)) {
            for (contentType in contentTypes) {
                try {
                    val accepted = postOnce(ip, port, body, contentType)
                    if (accepted) return true
                } catch (error: Exception) {
                    lastError = error
                }
            }
        }
        if (lastError != null) throw lastError
        return false
    }

    private fun postOnce(ip: String, port: Int, body: String, contentType: String): Boolean {
        val url = URL("http://$ip:$port/apps/SmartCenter")
        val bytes = body.toByteArray(Charsets.UTF_8)
        val connection = (url.openConnection() as HttpURLConnection).apply {
            requestMethod = "POST"
            doOutput = true
            connectTimeout = 3000
            readTimeout = 3000
            instanceFollowRedirects = true
            setRequestProperty("Content-Type", contentType)
            setRequestProperty("Content-Length", bytes.size.toString())
            setRequestProperty("Connection", "Keep-Alive")
            setRequestProperty("User-Agent", "IRTVRemote/1.0")
        }
        connection.outputStream.use { it.write(bytes) }
        val code = connection.responseCode
        try {
            (if (code >= 400) connection.errorStream else connection.inputStream)?.close()
        } catch (_: Exception) {
        }
        // Real Vestel/Haier SmartCenter returns 200/201/204 when the key is accepted
        return code in 200..299
    }

    private fun extractTag(xml: String, tag: String): String? {
        val regex = "<$tag>(.*?)</$tag>".toRegex(RegexOption.IGNORE_CASE)
        return regex.find(xml)?.groupValues?.getOrNull(1)?.trim()?.takeIf { it.isNotEmpty() }
    }

    companion object {
        private const val TAG = "HaierWifi"
        private const val KEY_INFO = 1018
        private val IPV4 = Regex("""^(\d{1,3}\.){3}\d{1,3}$""")
        val COMMAND_PORTS = intArrayOf(56789, 56791)
    }
}
