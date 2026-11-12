package com.irremote.tv.net.androidtv

import android.util.Log
import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.net.DiscoveredTv
import com.irremote.tv.net.NeedsPairingException
import com.irremote.tv.net.RemoteSession
import com.irremote.tv.net.TrustAll
import java.io.IOException
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit
import javax.net.ssl.SSLException
import javax.net.ssl.SSLSocket

/**
 * Android TV Remote v2 command channel on port 6466 (same protocol as Google's TV remote app).
 */
class AndroidTvSession(
    override val tv: DiscoveredTv,
    private val port: Int,
    private val identity: ClientIdentity,
    private val timeoutMs: Int = 8000
) : RemoteSession {

    @Volatile private var socket: SSLSocket? = null
    @Volatile private var ready = false
    @Volatile private var imeCounter = 0L
    @Volatile private var imeFieldCounter = 0L
    private val writeLock = Any()

    override val isOpen: Boolean get() = socket?.isClosed == false && ready
    override val supportsText: Boolean = true

    fun open() {
        close()
        val ctx = TrustAll.sslContext(identity.keyManagers())
        val s = try {
            TrustAll.openTls(ctx, tv.ip, port, timeoutMs)
        } catch (error: SSLException) {
            // TV rejects certificates it hasn't paired with during the handshake
            throw NeedsPairingException("TV needs pairing: ${error.message}")
        }
        s.soTimeout = 0
        socket = s
        val configured = CountDownLatch(1)
        Thread({ readLoop(s, configured) }, "atv-remote-${tv.ip}").apply { isDaemon = true }.start()
        if (!configured.await(timeoutMs.toLong(), TimeUnit.MILLISECONDS) || !ready) {
            close()
            throw NeedsPairingException("TV did not accept this phone — pair with the code on the TV")
        }
        Log.i(TAG, "Remote ready on ${tv.ip}")
    }

    private fun readLoop(s: SSLSocket, configured: CountDownLatch) {
        try {
            val input = s.inputStream
            while (!s.isClosed) {
                val frame = ProtoReader.readFrame(input) ?: break
                val msg = ProtoReader.parse(frame)
                handle(msg, configured)
            }
        } catch (error: IOException) {
            Log.d(TAG, "Remote socket closed: ${error.message}")
        } catch (error: Exception) {
            Log.w(TAG, "Remote read error", error)
        } finally {
            ready = false
            configured.countDown()
            runCatching { s.close() }
        }
    }

    private fun handle(msg: ProtoMessage, configured: CountDownLatch) {
        when {
            msg.has(1) -> {
                val serverFeatures = msg.message(1)?.varint(1) ?: OUR_FEATURES
                val active = serverFeatures and OUR_FEATURES
                write(ProtoWriter().message(1, ProtoWriter()
                    .varint(1, active)
                    .message(2, ProtoWriter()
                        .string(1, "IR TV Remote")
                        .string(2, "Android")
                        .varint(3, 1)
                        .string(4, "1")
                        .string(5, "atvremote")
                        .string(6, "1.0.0"))))
            }
            msg.has(2) -> {
                write(ProtoWriter().message(2, ProtoWriter().varint(1, OUR_FEATURES)))
                ready = true
                configured.countDown()
            }
            msg.has(8) -> {
                val v = msg.message(8)?.varint(1) ?: 0L
                write(ProtoWriter().message(9, ProtoWriter().varint(1, v)))
            }
            msg.has(40) -> {
                ready = true
                configured.countDown()
            }
            msg.has(20) -> {
                val inject = msg.message(20) ?: ProtoMessage.EMPTY
                imeCounter = inject.message(1)?.varint(1) ?: imeCounter
                imeFieldCounter = inject.message(2)?.varint(1) ?: imeFieldCounter
            }
            msg.has(22) -> {
                imeFieldCounter = msg.message(22)?.message(2)?.varint(1) ?: imeFieldCounter
            }
            msg.has(21) -> {
                val edit = msg.message(21) ?: ProtoMessage.EMPTY
                if (imeCounter == 0L) imeCounter = edit.varint(1) ?: 0L
                if (imeFieldCounter == 0L) imeFieldCounter = edit.varint(2) ?: 0L
            }
        }
    }

    private fun write(msg: ProtoWriter) {
        val s = socket ?: throw IOException("Not connected")
        synchronized(writeLock) {
            s.outputStream.write(ProtoWriter.frame(msg.toByteArray()))
            s.outputStream.flush()
        }
    }

    private fun ensureOpen() {
        if (!isOpen) open()
    }

    fun sendKeyCode(keyCode: Int): TransmitResult = try {
        ensureOpen()
        write(ProtoWriter().message(10, ProtoWriter().varint(1, keyCode).varint(2, DIRECTION_SHORT)))
        TransmitResult.NETWORK_SENT
    } catch (error: NeedsPairingException) {
        TransmitResult.Failed("Android TV needs pairing again — reconnect from the Wi‑Fi panel")
    } catch (error: Exception) {
        ready = false
        TransmitResult.Failed("Android TV: ${error.message ?: "send failed"}")
    }

    override fun send(command: RemoteCommand): TransmitResult = sendKeyCode(AndroidTvKeys.keyCode(command))

    override fun sendText(text: String): TransmitResult {
        if (text == "\b") return sendKeyCode(AndroidTvKeys.KEYCODE_DEL)
        if (text == "\n") return sendKeyCode(AndroidTvKeys.KEYCODE_ENTER)
        if (imeCounter == 0L && imeFieldCounter == 0L) {
            // No focused text field reported yet — type with key events instead
            for (ch in text) {
                val code = AndroidTvKeys.keyCodeForChar(ch)
                    ?: return TransmitResult.Failed("Can't type '$ch' with key events")
                val result = sendKeyCode(code)
                if (result is TransmitResult.Failed) return result
            }
            return TransmitResult.NETWORK_SENT
        }
        return try {
            ensureOpen()
            write(ProtoWriter().message(21, ProtoWriter()
                .varint(1, imeCounter)
                .varint(2, imeFieldCounter)
                .message(3, ProtoWriter()
                    .varint(1, 1)
                    .message(2, ProtoWriter()
                        .varint(1, text.length)
                        .varint(2, text.length)
                        .string(3, text)))))
            TransmitResult.NETWORK_SENT
        } catch (error: Exception) {
            TransmitResult.Failed("Android TV typing failed: ${error.message}")
        }
    }

    override fun close() {
        ready = false
        runCatching { socket?.close() }
        socket = null
    }

    companion object {
        private const val TAG = "AndroidTvSession"
        private const val DIRECTION_SHORT = 3
        // PING | KEY | IME | POWER | VOLUME | APP_LINK
        const val OUR_FEATURES = 1L or 2L or 4L or 32L or 64L or 512L
    }
}
