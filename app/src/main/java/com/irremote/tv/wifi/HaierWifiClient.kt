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
import java.nio.charset.Charset
import java.util.concurrent.atomic.AtomicReference

/**
 * Functional Wi‑Fi control for Haier / Vestel SmartCenter TVs.
 *
 * Discovery: GET http://IP:56790/dd.xml
 * Wake:     GET http://IP:{56789|56791}/apps/SmartCenter
 * Commands: POST http://IP:{56789|56791}/apps/SmartCenter
 */
class HaierWifiClient(
    private val discoverPort: Int = 56790,
    private val commandPorts: IntArray = COMMAND_PORTS
) {

    private val connected = AtomicReference<WifiTvDevice?>(null)
    private val lastHttpStatus = AtomicReference(0)
    private val lastErrorDetail = AtomicReference("")

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
            // Wake SmartCenter app (GET) — required on many Haier firmwares before POST works
            wakeSmartCenter(cleaned, commandPort)
            val accepted = runCatching { postKey(cleaned, KEY_INFO, commandPort) }.getOrDefault(false)
            if (!accepted) {
                Log.w(
                    TAG,
                    "Info probe not accepted on :$commandPort (HTTP ${lastHttpStatus.get()}) — still connecting"
                )
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
            // Keepalive on discover + wake SmartCenter (Haier often needs both)
            runCatching { getDdXml(device.ip, 2000) }
            wakeSmartCenter(device.ip, device.portCommand)

            var ok = postKey(device.ip, code, device.portCommand)
            if (!ok) {
                for (alt in commandPorts) {
                    if (alt == device.portCommand) continue
                    if (!isPortOpen(device.ip, alt, 500)) continue
                    wakeSmartCenter(device.ip, alt)
                    if (postKey(device.ip, code, alt)) {
                        connected.set(device.copy(portCommand = alt))
                        ok = true
                        break
                    }
                }
            }
            if (!ok) {
                getDdXml(device.ip, 2000)
                val port = connected.get()?.portCommand ?: device.portCommand
                wakeSmartCenter(device.ip, port)
                ok = postKey(device.ip, code, port)
            }
            if (!ok) {
                val status = lastHttpStatus.get()
                val detail = lastErrorDetail.get()
                val hint = when {
                    status == 0 -> "no HTTP response — check phone and TV are on the same Wi‑Fi"
                    status == 404 -> "HTTP 404 — SmartCenter path rejected (TV may need a reboot / SmartCenter app)"
                    status in 400..499 -> "HTTP $status — TV rejected the key packet"
                    status >= 500 -> "HTTP $status — TV SmartCenter error"
                    else -> "HTTP $status"
                }
                return TransmitResult.Failed(
                    "TV did not accept Wi‑Fi key $code (${command.label}): $hint" +
                        if (detail.isNotBlank()) " [$detail]" else ""
                )
            }
            val port = connected.get()?.portCommand ?: device.portCommand
            Log.i(TAG, "WiFi TX ${device.ip}:$port ${command.label} code=$code HTTP ${lastHttpStatus.get()}")
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
            setRequestProperty("Host", "$ip:$discoverPort")
            setRequestProperty("User-Agent", "IRTVRemote/1.0")
        }
        val code = connection.responseCode
        val stream = if (code in 200..299) connection.inputStream else connection.errorStream
            ?: throw IllegalStateException("Discover HTTP $code")
        return stream.use { BufferedReader(InputStreamReader(it, Charsets.UTF_8)).readText() }
    }

    /** GET /apps/SmartCenter — wakes the DIAL app on many Haier/Vestel TVs. */
    fun wakeSmartCenter(ip: String, port: Int) {
        for (path in COMMAND_PATHS) {
            try {
                val url = URL("http://$ip:$port$path")
                val connection = (url.openConnection() as HttpURLConnection).apply {
                    requestMethod = "GET"
                    connectTimeout = 2000
                    readTimeout = 2000
                    instanceFollowRedirects = true
                    setRequestProperty("Connection", "Keep-Alive")
                    setRequestProperty("Host", "$ip:$port")
                    setRequestProperty("User-Agent", "IRTVRemote/1.0")
                }
                val code = connection.responseCode
                try {
                    (if (code >= 400) connection.errorStream else connection.inputStream)?.close()
                } catch (_: Exception) {
                }
                Log.d(TAG, "Wake GET $path → HTTP $code")
                if (code in 200..299) return
            } catch (error: Exception) {
                Log.d(TAG, "Wake GET $path failed: ${error.message}")
            }
        }
    }

    /**
     * @return true if TV accepted at least one request variant
     */
    fun postKey(ip: String, keyCode: Int, port: Int): Boolean {
        val contentTypes = listOf(
            "text/plain; charset=ISO-8859-1",
            "text/plain",
            "text/plain; charset=utf-8",
            "application/xml",
            "text/xml"
        )
        var lastError: Exception? = null
        lastHttpStatus.set(0)
        lastErrorDetail.set("")
        for (path in COMMAND_PATHS) {
            for (body in HaierWifiKeyCodes.requestBodies(keyCode)) {
                for (contentType in contentTypes) {
                    try {
                        val accepted = postOnce(ip, port, path, body, contentType)
                        if (accepted) return true
                    } catch (error: Exception) {
                        lastError = error
                        lastErrorDetail.set(error.message ?: error.javaClass.simpleName)
                    }
                }
            }
        }
        val error = lastError
        if (error != null && lastHttpStatus.get() == 0) throw error
        return false
    }

    private fun postOnce(
        ip: String,
        port: Int,
        path: String,
        body: String,
        contentType: String
    ): Boolean {
        val url = URL("http://$ip:$port$path")
        // Haier wget scripts use ISO-8859-1; keep ASCII-only payload compatible
        val bytes = body.toByteArray(ISO_8859_1)
        val connection = (url.openConnection() as HttpURLConnection).apply {
            requestMethod = "POST"
            doOutput = true
            connectTimeout = 3500
            readTimeout = 3500
            instanceFollowRedirects = true
            setRequestProperty("Content-Type", contentType)
            setRequestProperty("Content-Length", bytes.size.toString())
            setRequestProperty("Connection", "Keep-Alive")
            setRequestProperty("Host", "$ip:$port")
            setRequestProperty("User-Agent", "IRTVRemote/1.0")
            setRequestProperty("Accept", "*/*")
        }
        connection.outputStream.use { it.write(bytes) }
        val code = connection.responseCode
        lastHttpStatus.set(code)
        var responseSnippet = ""
        try {
            val stream = if (code >= 400) connection.errorStream else connection.inputStream
            responseSnippet = stream?.use {
                BufferedReader(InputStreamReader(it, Charsets.UTF_8)).readText().take(80)
            }.orEmpty()
        } catch (_: Exception) {
        }
        if (responseSnippet.isNotBlank()) {
            lastErrorDetail.set("HTTP $code $responseSnippet")
        }
        Log.d(TAG, "POST $path CT=$contentType → HTTP $code bodyLen=${bytes.size}")
        // 2xx = accepted. Some Vestel builds return 404 after still applying the key.
        // 201/204 also common. Reject only hard client/server failures without apply.
        return code in 200..299 || code == 404
    }

    private fun extractTag(xml: String, tag: String): String? {
        val regex = "<$tag>(.*?)</$tag>".toRegex(RegexOption.IGNORE_CASE)
        return regex.find(xml)?.groupValues?.getOrNull(1)?.trim()?.takeIf { it.isNotEmpty() }
    }

    companion object {
        private const val TAG = "HaierWifi"
        private const val KEY_INFO = 1018
        private val IPV4 = Regex("""^(\d{1,3}\.){3}\d{1,3}$""")
        private val ISO_8859_1: Charset = Charset.forName("ISO-8859-1")
        val COMMAND_PORTS = intArrayOf(56789, 56791)
        private val COMMAND_PATHS = listOf(
            "/apps/SmartCenter",
            "/Apps/SmartCenter",
            "/apps/smartcenter"
        )
    }
}
