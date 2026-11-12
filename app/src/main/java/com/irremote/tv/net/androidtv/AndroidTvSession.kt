package com.irremote.tv.net.androidtv

import android.util.Log
import com.irremote.tv.control.InputSource
import com.irremote.tv.control.TvApp
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
    @Volatile private var hasImeCounter = false
    @Volatile private var hasImeFieldCounter = false
    @Volatile private var imeSeen = false
    @Volatile private var voiceSessionId: Int? = null
    private var voiceBeginLatch: CountDownLatch? = null
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
                imeCounter = inject.message(1)?.varint(1) ?: 0L
                imeFieldCounter = inject.message(2)?.varint(1) ?: 0L
                hasImeCounter = imeCounter != 0L
                hasImeFieldCounter = imeFieldCounter != 0L
                imeSeen = true
            }
            msg.has(22) -> {
                msg.message(22)?.message(2)?.varint(1)?.let {
                    imeFieldCounter = it
                    hasImeFieldCounter = true
                }
                imeSeen = true
            }
            msg.has(21) -> {
                val edit = msg.message(21) ?: ProtoMessage.EMPTY
                if (!hasImeCounter) imeCounter = edit.varint(1) ?: imeCounter
                if (!hasImeFieldCounter) imeFieldCounter = edit.varint(2) ?: imeFieldCounter
                imeSeen = true
            }
            // TV starts a voice session after KEYCODE_SEARCH (Google Assistant mic)
            msg.has(30) -> {
                val begin = msg.message(30) ?: ProtoMessage.EMPTY
                val id = (begin.varint(1) ?: 0L).toInt()
                voiceSessionId = id
                voiceBeginLatch?.countDown()
                Log.i(TAG, "TV voice begin session=$id pkg=${begin.string(2)}")
            }
            msg.has(32) -> {
                voiceSessionId = null
                Log.i(TAG, "TV ended voice session")
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
        // Google TV drops injected letter key events in text fields; only digits survive as keys.
        // Text therefore goes through the IME channel unless it is all digits and no field was reported.
        if (!imeSeen && text.all { it in '0'..'9' }) {
            for (ch in text) {
                val result = sendKeyCode(AndroidTvKeys.keyCodeForChar(ch)!!)
                if (result is TransmitResult.Failed) return result
            }
            return TransmitResult.NETWORK_SENT
        }
        return try {
            ensureOpen()
            write(imeBatchEdit(imeCounter, imeFieldCounter, text))
            TransmitResult.NETWORK_SENT
        } catch (error: Exception) {
            TransmitResult.Failed("Android TV typing failed: ${error.message}")
        }
    }

    override val supportsVoice: Boolean = true

    /**
     * Opens Google Assistant voice search on the TV, then waits for the TV's VoiceBegin
     * so PCM from the phone mic can be streamed.
     */
    override fun startVoice(): TransmitResult {
        voiceSessionId = null
        val latch = CountDownLatch(1)
        voiceBeginLatch = latch
        val search = sendKeyCode(AndroidTvKeys.KEYCODE_SEARCH)
        if (search is TransmitResult.Failed) {
            voiceBeginLatch = null
            return search
        }
        return try {
            if (!latch.await(4, TimeUnit.SECONDS) || voiceSessionId == null) {
                TransmitResult.Failed("TV did not start voice search. Open Google Assistant on the TV and try again.")
            } else {
                val id = voiceSessionId!!
                // Acknowledge the session (required before the TV accepts audio)
                write(ProtoWriter().message(30, ProtoWriter().varint(1, id)))
                TransmitResult.NETWORK_SENT
            }
        } catch (error: Exception) {
            TransmitResult.Failed("Voice search failed: ${error.message}")
        } finally {
            voiceBeginLatch = null
        }
    }

    override fun sendVoicePcm(samples: ByteArray): TransmitResult {
        val id = voiceSessionId ?: return TransmitResult.Failed("Voice search is not active")
        return try {
            ensureOpen()
            // Google TV expects ~20 KB chunks of 16-bit LE PCM @ 8 kHz mono
            var offset = 0
            while (offset < samples.size) {
                val end = minOf(offset + VOICE_CHUNK, samples.size)
                val chunk = samples.copyOfRange(offset, end)
                write(ProtoWriter().message(31, ProtoWriter().varint(1, id).bytes(2, chunk)))
                offset = end
            }
            TransmitResult.NETWORK_SENT
        } catch (error: Exception) {
            ready = false
            TransmitResult.Failed("Voice audio failed: ${error.message}")
        }
    }

    override fun endVoice(): TransmitResult {
        val id = voiceSessionId ?: return TransmitResult.NETWORK_SENT
        return try {
            ensureOpen()
            write(ProtoWriter().message(32, ProtoWriter().varint(1, id)))
            TransmitResult.NETWORK_SENT
        } catch (error: Exception) {
            TransmitResult.Failed("Couldn't end voice: ${error.message}")
        } finally {
            voiceSessionId = null
        }
    }

    override fun launchApp(app: TvApp): TransmitResult = try {
        ensureOpen()
        write(ProtoWriter().message(90, ProtoWriter().string(1, app.androidTvLink)))
        TransmitResult.NETWORK_SENT
    } catch (error: Exception) {
        ready = false
        TransmitResult.Failed("Couldn't open ${app.label}: ${error.message}")
    }

    override fun inputSources(): List<InputSource> = InputSource.entries

    override fun selectInput(source: InputSource): TransmitResult = sendKeyCode(
        when (source) {
            InputSource.INPUT_MENU -> AndroidTvKeys.KEYCODE_INPUTS_PANEL
            InputSource.HDMI1 -> 243
            InputSource.HDMI2 -> 244
            InputSource.HDMI3 -> 245
            InputSource.HDMI4 -> 246
            InputSource.TV -> 170
            InputSource.SETTINGS -> 176
        }
    )

    override fun close() {
        ready = false
        voiceSessionId = null
        voiceBeginLatch?.countDown()
        voiceBeginLatch = null
        runCatching { socket?.close() }
        socket = null
    }

    companion object {
        private const val TAG = "AndroidTvSession"

        fun imeBatchEdit(imeCounter: Long, fieldCounter: Long, text: String): ProtoWriter =
            ProtoWriter().message(21, ProtoWriter()
                .varint(1, imeCounter)
                .varint(2, fieldCounter)
                .message(3, ProtoWriter()
                    .varint(1, 1)
                    .message(2, ProtoWriter()
                        .varint(1, text.length)
                        .varint(2, text.length)
                        .string(3, text))))
        private const val DIRECTION_SHORT = 3
        private const val VOICE_CHUNK = 20 * 1024
        // PING | KEY | IME | POWER | VOLUME | APP_LINK
        const val OUR_FEATURES = 1L or 2L or 4L or 32L or 64L or 512L
    }
}
