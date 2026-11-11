package com.irremote.tv.wifi

import android.util.Log
import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import java.io.BufferedReader
import java.io.InputStreamReader
import java.io.OutputStreamWriter
import java.net.HttpURLConnection
import java.net.InetSocketAddress
import java.net.Socket
import java.net.URL
import java.nio.charset.Charset
import java.util.concurrent.atomic.AtomicReference

/**
 * Functional Wi‑Fi control for Haier (Vestel SmartCenter) TVs on the LAN.
 * Discover/keepalive: GET http://IP:56790/dd.xml
 * Commands: POST http://IP:56789/apps/SmartCenter with XML key codes.
 */
class HaierWifiClient {

    private val connected = AtomicReference<WifiTvDevice?>(null)

    val device: WifiTvDevice?
        get() = connected.get()

    val isConnected: Boolean
        get() = connected.get() != null

    fun connect(ip: String, timeoutMs: Int = 2500): Result<WifiTvDevice> {
        val cleaned = ip.trim()
        if (!IPV4.matches(cleaned)) {
            return Result.failure(IllegalArgumentException("Enter a valid IPv4 address"))
        }
        return try {
            val xml = getDdXml(cleaned, timeoutMs)
            val name = extractTag(xml, "friendlyName") ?: "Haier TV"
            val model = extractTag(xml, "modelName") ?: ""
            val device = WifiTvDevice(ip = cleaned, name = name, model = model)
            connected.set(device)
            Result.success(device)
        } catch (error: Exception) {
            connected.set(null)
            Result.failure(error)
        }
    }

    fun disconnect() {
        connected.set(null)
    }

    fun keepAlive(): Boolean {
        val device = connected.get() ?: return false
        return try {
            getDdXml(device.ip, 2000)
            true
        } catch (_: Exception) {
            false
        }
    }

    fun send(command: RemoteCommand): TransmitResult {
        val device = connected.get()
            ?: return TransmitResult.Failed("Not connected over Wi‑Fi. Scan/connect to your Haier TV first.")
        val code = HaierWifiKeyCodes.codeFor(command)
            ?: return TransmitResult.Failed("No Wi‑Fi key mapping for ${command.label}")
        return try {
            postKey(device.ip, code, device.portCommand)
            Log.i(TAG, "WiFi TX ${device.ip} ${command.label} code=$code")
            // Reuse Sent with dummy pattern metadata for UI compatibility
            TransmitResult.Sent(
                pattern = com.irremote.tv.ir.IrPattern(0, intArrayOf(1)),
                repeats = 1
            )
        } catch (error: Exception) {
            // Retry once after keepalive (API docs say GET may be needed again)
            return try {
                getDdXml(device.ip, 2000)
                postKey(device.ip, code, device.portCommand)
                TransmitResult.Sent(
                    pattern = com.irremote.tv.ir.IrPattern(0, intArrayOf(1)),
                    repeats = 1
                )
            } catch (retryError: Exception) {
                TransmitResult.Failed(retryError.message ?: "Wi‑Fi command failed")
            }
        }
    }

    fun probe(ip: String, timeoutMs: Int = 800): WifiTvDevice? {
        return try {
            val xml = getDdXml(ip, timeoutMs)
            WifiTvDevice(
                ip = ip,
                name = extractTag(xml, "friendlyName") ?: "Haier TV",
                model = extractTag(xml, "modelName") ?: ""
            )
        } catch (_: Exception) {
            null
        }
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

    private fun getDdXml(ip: String, timeoutMs: Int): String {
        val url = URL("http://$ip:56790/dd.xml")
        val connection = (url.openConnection() as HttpURLConnection).apply {
            requestMethod = "GET"
            connectTimeout = timeoutMs
            readTimeout = timeoutMs
            setRequestProperty("Connection", "Keep-Alive")
            setRequestProperty("Host", "$ip:56790")
        }
        connection.inputStream.use { stream ->
            return BufferedReader(InputStreamReader(stream, Charsets.UTF_8)).readText()
        }
    }

    private fun postKey(ip: String, keyCode: Int, port: Int) {
        val url = URL("http://$ip:$port/apps/SmartCenter")
        val body = HaierWifiKeyCodes.requestBody(keyCode)
        val connection = (url.openConnection() as HttpURLConnection).apply {
            requestMethod = "POST"
            doOutput = true
            connectTimeout = 2500
            readTimeout = 2500
            setRequestProperty("Content-Type", "text/plain; charset=utf-8")
            setRequestProperty("Connection", "Keep-Alive")
        }
        OutputStreamWriter(connection.outputStream, Charsets.UTF_8).use { it.write(body) }
        val code = connection.responseCode
        // Many TVs return 200/204/404 interchangeably after accepting the key
        if (code !in 200..499) {
            throw IllegalStateException("TV HTTP $code")
        }
        try {
            connection.inputStream?.close()
        } catch (_: Exception) {
            connection.errorStream?.close()
        }
    }

    private fun extractTag(xml: String, tag: String): String? {
        val regex = "<$tag>(.*?)</$tag>".toRegex(RegexOption.IGNORE_CASE)
        return regex.find(xml)?.groupValues?.getOrNull(1)?.trim()?.takeIf { it.isNotEmpty() }
    }

    companion object {
        private const val TAG = "HaierWifi"
        private val IPV4 = Regex("""^(\d{1,3}\.){3}\d{1,3}$""")
    }
}
