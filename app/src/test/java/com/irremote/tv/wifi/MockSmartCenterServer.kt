package com.irremote.tv.wifi

import java.io.BufferedReader
import java.io.InputStreamReader
import java.io.OutputStreamWriter
import java.net.ServerSocket
import java.net.Socket
import java.util.concurrent.CopyOnWriteArrayList
import java.util.concurrent.Executors
import java.util.concurrent.atomic.AtomicBoolean
import java.util.concurrent.atomic.AtomicInteger

/**
 * Minimal HTTP mock of a Vestel/Haier SmartCenter TV for JVM unit tests.
 */
class MockSmartCenterServer(
    private val discoverXml: String = DEFAULT_DD_XML,
    private var commandStatus: Int = 200
) {
    private val running = AtomicBoolean(false)
    private val executor = Executors.newCachedThreadPool()
    private lateinit var discoverSocket: ServerSocket
    private lateinit var commandSocket: ServerSocket

    val receivedBodies = CopyOnWriteArrayList<String>()
    val receivedContentTypes = CopyOnWriteArrayList<String>()
    val receivedPaths = CopyOnWriteArrayList<String>()
    private val statusOverride = AtomicInteger(commandStatus)

    val discoverPort: Int get() = discoverSocket.localPort
    val commandPort: Int get() = commandSocket.localPort

    fun start() {
        discoverSocket = ServerSocket(0)
        commandSocket = ServerSocket(0)
        running.set(true)
        executor.execute { acceptLoop(discoverSocket, discover = true) }
        executor.execute { acceptLoop(commandSocket, discover = false) }
    }

    fun setCommandStatus(code: Int) {
        statusOverride.set(code)
    }

    fun stop() {
        running.set(false)
        runCatching { discoverSocket.close() }
        runCatching { commandSocket.close() }
        executor.shutdownNow()
    }

    private fun acceptLoop(server: ServerSocket, discover: Boolean) {
        while (running.get()) {
            val socket = try {
                server.accept()
            } catch (_: Exception) {
                break
            }
            executor.execute { handle(socket, discover) }
        }
    }

    private fun handle(socket: Socket, discover: Boolean) {
        socket.use { s ->
            val reader = BufferedReader(InputStreamReader(s.getInputStream(), Charsets.UTF_8))
            val requestLine = reader.readLine() ?: return
            val parts = requestLine.split(" ")
            val method = parts.getOrNull(0).orEmpty()
            val path = parts.getOrNull(1).orEmpty()
            receivedPaths += path

            var contentLength = 0
            var contentType = ""
            while (true) {
                val line = reader.readLine() ?: break
                if (line.isEmpty()) break
                val lower = line.lowercase()
                if (lower.startsWith("content-length:")) {
                    contentLength = lower.substringAfter(":").trim().toIntOrNull() ?: 0
                }
                if (lower.startsWith("content-type:")) {
                    contentType = line.substringAfter(":").trim()
                }
            }

            val body = if (contentLength > 0) {
                val buf = CharArray(contentLength)
                var read = 0
                while (read < contentLength) {
                    val n = reader.read(buf, read, contentLength - read)
                    if (n < 0) break
                    read += n
                }
                String(buf, 0, read)
            } else {
                ""
            }

            val writer = OutputStreamWriter(s.getOutputStream(), Charsets.UTF_8)
            if (discover) {
                if (method == "GET" && path.startsWith("/dd.xml")) {
                    writeResponse(writer, 200, "application/xml", discoverXml)
                } else {
                    writeResponse(writer, 404, "text/plain", "not found")
                }
            } else {
                val smartCenter = path.contains("smartcenter", ignoreCase = true)
                when {
                    method == "GET" && smartCenter -> {
                        writeResponse(
                            writer,
                            200,
                            "application/xml",
                            """<?xml version="1.0"?><service><name>SmartCenter</name><state>running</state></service>"""
                        )
                    }
                    method == "POST" && smartCenter -> {
                        receivedBodies += body
                        receivedContentTypes += contentType
                        val code = statusOverride.get()
                        if (code in 200..299 || code == 404) {
                            writeResponse(writer, code, "text/plain", if (code == 404) "ERR" else "OK")
                        } else {
                            writeResponse(writer, code, "text/plain", "ERR")
                        }
                    }
                    else -> writeResponse(writer, 404, "text/plain", "not found")
                }
            }
        }
    }

    private fun writeResponse(writer: OutputStreamWriter, code: Int, contentType: String, body: String) {
        val bytes = body.toByteArray(Charsets.UTF_8)
        writer.write("HTTP/1.1 $code ${reason(code)}\r\n")
        writer.write("Content-Type: $contentType\r\n")
        writer.write("Content-Length: ${bytes.size}\r\n")
        writer.write("Connection: close\r\n")
        writer.write("\r\n")
        writer.write(body)
        writer.flush()
    }

    private fun reason(code: Int): String = when (code) {
        200 -> "OK"
        201 -> "Created"
        204 -> "No Content"
        404 -> "Not Found"
        500 -> "Internal Server Error"
        else -> "OK"
    }

    companion object {
        const val DEFAULT_DD_XML = """<?xml version="1.0"?>
<root>
  <device>
    <friendlyName>Mock Haier TV</friendlyName>
    <modelName>LE55U7000UG</modelName>
  </device>
</root>"""
    }
}
