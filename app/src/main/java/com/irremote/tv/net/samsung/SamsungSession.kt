package com.irremote.tv.net.samsung

import android.util.Base64
import android.util.Log
import com.irremote.tv.control.InputSource
import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.net.DiscoveredTv
import com.irremote.tv.net.PairingStore
import com.irremote.tv.net.PromptListener
import com.irremote.tv.net.RemoteSession
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import okhttp3.WebSocket
import okhttp3.WebSocketListener
import org.json.JSONObject
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit

/**
 * Samsung Tizen (2016+) remote over WebSocket: wss://IP:8002 (token) or ws://IP:8001.
 * First connection shows an Allow/Deny prompt on the TV; the token is saved afterwards.
 */
class SamsungSession(
    override val tv: DiscoveredTv,
    private val store: PairingStore,
    private val client: OkHttpClient,
    private val wssPort: Int = 8002,
    private val wsPort: Int = 8001,
    private val appName: String = "IR TV Remote",
    private val approvalTimeoutMs: Long = 30_000,
    private val base64: (String) -> String = { Base64.encodeToString(it.toByteArray(), Base64.NO_WRAP) }
) : RemoteSession {

    @Volatile private var socket: WebSocket? = null
    @Volatile private var connected = false
    @Volatile private var textStarted = false

    override val isOpen: Boolean get() = connected && socket != null
    override val supportsText: Boolean = true

    /** @throws IllegalStateException with a user‑facing reason when the TV refuses. */
    fun open(prompt: PromptListener?) {
        close()
        val errors = ArrayList<String>()
        for ((scheme, port) in listOf("wss" to wssPort, "ws" to wsPort)) {
            val error = tryOpen(scheme, port, prompt) ?: return
            errors += "$scheme:$port $error"
            if (error.startsWith(DENIED)) break
        }
        throw IllegalStateException("Samsung TV: ${errors.joinToString("; ")}")
    }

    private fun tryOpen(scheme: String, port: Int, prompt: PromptListener?): String? {
        val token = store.samsungToken(tv.ip)
        val url = buildString {
            append("$scheme://${tv.ip}:$port/api/v2/channels/samsung.remote.control?name=")
            append(base64(appName))
            if (!token.isNullOrBlank()) append("&token=").append(token)
        }
        val done = CountDownLatch(1)
        var failure: String? = "no response"
        val listener = object : WebSocketListener() {
            override fun onMessage(webSocket: WebSocket, text: String) {
                val json = runCatching { JSONObject(text) }.getOrNull() ?: return
                when (json.optString("event")) {
                    "ms.channel.connect" -> {
                        json.optJSONObject("data")?.optString("token")?.takeIf { it.isNotBlank() }?.let {
                            store.setSamsungToken(tv.ip, it)
                        }
                        connected = true
                        failure = null
                        done.countDown()
                    }
                    "ms.channel.unauthorized" -> {
                        failure = "$DENIED — allow this phone in TV Settings > General > External Device Manager"
                        done.countDown()
                    }
                    "ms.channel.timeOut" -> {
                        failure = "the TV prompt timed out"
                        done.countDown()
                    }
                    "ms.remote.imeStart" -> textStarted = false
                }
            }

            override fun onFailure(webSocket: WebSocket, t: Throwable, response: Response?) {
                connected = false
                if (done.count > 0) {
                    failure = t.message ?: "connection failed"
                    done.countDown()
                }
            }

            override fun onClosed(webSocket: WebSocket, code: Int, reason: String) {
                connected = false
                if (done.count > 0) {
                    failure = "closed ($code $reason)"
                    done.countDown()
                }
            }
        }
        val ws = client.newWebSocket(Request.Builder().url(url).build(), listener)
        socket = ws
        if (token.isNullOrBlank()) prompt?.onPrompt("Press Allow on your Samsung TV")
        if (!done.await(approvalTimeoutMs, TimeUnit.MILLISECONDS)) failure = "no answer from TV"
        if (failure != null) {
            ws.cancel()
            socket = null
            return failure
        }
        Log.i(TAG, "Connected to ${tv.ip} via $scheme:$port")
        return null
    }

    private fun emit(params: JSONObject): TransmitResult {
        val ws = socket
        if (ws == null || !connected) return TransmitResult.Failed("Samsung TV disconnected — reconnect from Wi‑Fi")
        val payload = JSONObject().put("method", "ms.remote.control").put("params", params)
        return if (ws.send(payload.toString())) TransmitResult.NETWORK_SENT
        else TransmitResult.Failed("Samsung TV: send failed")
    }

    fun sendKey(key: String): TransmitResult = emit(
        JSONObject()
            .put("Cmd", "Click")
            .put("DataOfCmd", key)
            .put("Option", "false")
            .put("TypeOfRemote", "SendRemoteKey")
    )

    override fun send(command: RemoteCommand): TransmitResult = sendKey(keyFor(command))

    override fun sendText(text: String): TransmitResult {
        if (text == "\b") return sendKey("KEY_BACKSPACE")
        if (text == "\n") return sendKey("KEY_ENTER")
        val ws = socket ?: return TransmitResult.Failed("Samsung TV disconnected")
        if (!textStarted) {
            ws.send(JSONObject().put("method", "ms.channel.emit").put("params",
                JSONObject().put("event", "custom.remote.textReceived").put("to", "broadcast")).toString())
            textStarted = true
        }
        return emit(
            JSONObject()
                .put("Cmd", base64(text))
                .put("DataOfCmd", "base64")
                .put("TypeOfRemote", "SendInputString")
        )
    }

    override fun inputSources(): List<InputSource> = InputSource.entries

    override fun selectInput(source: InputSource): TransmitResult = sendKey(
        when (source) {
            InputSource.INPUT_MENU -> "KEY_SOURCE"
            InputSource.HDMI1 -> "KEY_HDMI1"
            InputSource.HDMI2 -> "KEY_HDMI2"
            InputSource.HDMI3 -> "KEY_HDMI3"
            InputSource.HDMI4 -> "KEY_HDMI4"
            InputSource.TV -> "KEY_TV"
            InputSource.SETTINGS -> "KEY_MENU"
        }
    )

    override fun close() {
        connected = false
        socket?.close(1000, null)
        socket = null
    }

    companion object {
        private const val TAG = "SamsungSession"
        private const val DENIED = "access denied"

        fun keyFor(command: RemoteCommand): String = when (command) {
            RemoteCommand.POWER -> "KEY_POWER"
            RemoteCommand.MUTE -> "KEY_MUTE"
            RemoteCommand.VOL_UP -> "KEY_VOLUP"
            RemoteCommand.VOL_DOWN -> "KEY_VOLDOWN"
            RemoteCommand.CH_UP -> "KEY_CHUP"
            RemoteCommand.CH_DOWN -> "KEY_CHDOWN"
            RemoteCommand.UP -> "KEY_UP"
            RemoteCommand.DOWN -> "KEY_DOWN"
            RemoteCommand.LEFT -> "KEY_LEFT"
            RemoteCommand.RIGHT -> "KEY_RIGHT"
            RemoteCommand.OK -> "KEY_ENTER"
            RemoteCommand.HOME -> "KEY_HOME"
            RemoteCommand.BACK -> "KEY_RETURN"
            RemoteCommand.MENU -> "KEY_MENU"
            RemoteCommand.INPUT -> "KEY_SOURCE"
            RemoteCommand.DIGIT_0 -> "KEY_0"
            RemoteCommand.DIGIT_1 -> "KEY_1"
            RemoteCommand.DIGIT_2 -> "KEY_2"
            RemoteCommand.DIGIT_3 -> "KEY_3"
            RemoteCommand.DIGIT_4 -> "KEY_4"
            RemoteCommand.DIGIT_5 -> "KEY_5"
            RemoteCommand.DIGIT_6 -> "KEY_6"
            RemoteCommand.DIGIT_7 -> "KEY_7"
            RemoteCommand.DIGIT_8 -> "KEY_8"
            RemoteCommand.DIGIT_9 -> "KEY_9"
        }
    }
}
