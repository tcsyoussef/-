package com.irremote.tv.input

import android.Manifest
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaRecorder
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.speech.RecognitionListener
import android.speech.RecognizerIntent
import android.speech.SpeechRecognizer
import androidx.core.content.ContextCompat
import java.util.concurrent.Executors
import java.util.concurrent.atomic.AtomicBoolean

/**
 * Hold-to-talk mic:
 * - [streamPcm]: records 8 kHz mono PCM for Google TV Assistant over Wi‑Fi
 * - [dictate]: on-device speech recognition → text for TVs that can't take mic audio
 */
class VoiceController(private val context: Context) {

    interface Listener {
        fun onListening(active: Boolean)
        fun onLevel(level: Float)
        fun onPcm(samples: ByteArray)
        fun onDictation(text: String)
        fun onError(message: String)
    }

    var listener: Listener? = null

    private val main = Handler(Looper.getMainLooper())
    private val audioExecutor = Executors.newSingleThreadExecutor()
    private val recording = AtomicBoolean(false)
    private var speech: SpeechRecognizer? = null

    fun hasMicPermission(): Boolean =
        ContextCompat.checkSelfPermission(context, Manifest.permission.RECORD_AUDIO) ==
            PackageManager.PERMISSION_GRANTED

    fun startStreaming() {
        if (!recording.compareAndSet(false, true)) return
        main.post { listener?.onListening(true) }
        audioExecutor.execute { recordLoop() }
    }

    fun stopStreaming() {
        recording.set(false)
        main.post { listener?.onListening(false) }
    }

    fun startDictation() {
        if (!SpeechRecognizer.isRecognitionAvailable(context)) {
            listener?.onError("Speech recognition isn't available on this phone")
            return
        }
        main.post {
            listener?.onListening(true)
            val recognizer = speech ?: SpeechRecognizer.createSpeechRecognizer(context).also { speech = it }
            recognizer.setRecognitionListener(object : RecognitionListener {
                override fun onReadyForSpeech(params: Bundle?) = Unit
                override fun onBeginningOfSpeech() = Unit
                override fun onRmsChanged(rmsdB: Float) {
                    listener?.onLevel(((rmsdB + 2f) / 12f).coerceIn(0f, 1f))
                }
                override fun onBufferReceived(buffer: ByteArray?) = Unit
                override fun onEndOfSpeech() = Unit
                override fun onError(error: Int) {
                    listener?.onListening(false)
                    if (error != SpeechRecognizer.ERROR_CLIENT && error != SpeechRecognizer.ERROR_NO_MATCH) {
                        listener?.onError("Couldn't hear that — try again")
                    }
                }
                override fun onResults(results: Bundle?) {
                    listener?.onListening(false)
                    val text = results?.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION)
                        ?.firstOrNull()?.trim().orEmpty()
                    if (text.isNotEmpty()) listener?.onDictation(text)
                    else listener?.onError("No speech detected")
                }
                override fun onPartialResults(partialResults: Bundle?) = Unit
                override fun onEvent(eventType: Int, params: Bundle?) = Unit
            })
            val intent = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH).apply {
                putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM)
                putExtra(RecognizerIntent.EXTRA_PARTIAL_RESULTS, false)
                putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, 1)
            }
            recognizer.startListening(intent)
        }
    }

    fun stopDictation() {
        main.post {
            runCatching { speech?.stopListening() }
            listener?.onListening(false)
        }
    }

    fun release() {
        recording.set(false)
        main.post {
            speech?.destroy()
            speech = null
            listener?.onListening(false)
        }
        audioExecutor.shutdownNow()
    }

    private fun recordLoop() {
        val min = AudioRecord.getMinBufferSize(SAMPLE_RATE, CHANNEL, ENCODING)
        if (min <= 0) {
            main.post { listener?.onError("Microphone isn't available"); listener?.onListening(false) }
            recording.set(false)
            return
        }
        val bufferSize = maxOf(min, CHUNK_BYTES)
        val recorder = try {
            AudioRecord(MediaRecorder.AudioSource.VOICE_RECOGNITION, SAMPLE_RATE, CHANNEL, ENCODING, bufferSize)
        } catch (error: SecurityException) {
            main.post { listener?.onError("Microphone permission required"); listener?.onListening(false) }
            recording.set(false)
            return
        }
        if (recorder.state != AudioRecord.STATE_INITIALIZED) {
            recorder.release()
            main.post { listener?.onError("Couldn't open the microphone"); listener?.onListening(false) }
            recording.set(false)
            return
        }
        val buffer = ByteArray(CHUNK_BYTES)
        try {
            recorder.startRecording()
            while (recording.get()) {
                val read = recorder.read(buffer, 0, buffer.size)
                if (read > 0) {
                    val copy = buffer.copyOf(read)
                    main.post {
                        listener?.onLevel(pcmLevel(copy))
                        listener?.onPcm(copy)
                    }
                }
            }
        } catch (error: Exception) {
            main.post { listener?.onError(error.message ?: "Microphone error") }
        } finally {
            runCatching { recorder.stop() }
            recorder.release()
            recording.set(false)
            main.post { listener?.onListening(false) }
        }
    }

    private fun pcmLevel(samples: ByteArray): Float {
        var peak = 1
        var i = 0
        while (i + 1 < samples.size) {
            val sample = (samples[i].toInt() and 0xFF) or (samples[i + 1].toInt() shl 8)
            val abs = kotlin.math.abs(sample.toShort().toInt())
            if (abs > peak) peak = abs
            i += 2
        }
        return (peak / 32768f).coerceIn(0f, 1f)
    }

    companion object {
        const val SAMPLE_RATE = 8000
        private const val CHANNEL = AudioFormat.CHANNEL_IN_MONO
        private const val ENCODING = AudioFormat.ENCODING_PCM_16BIT
        /** ~100 ms of 8 kHz 16-bit mono. */
        private const val CHUNK_BYTES = SAMPLE_RATE * 2 / 10
    }
}
