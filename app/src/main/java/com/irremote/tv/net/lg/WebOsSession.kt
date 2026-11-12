package com.irremote.tv.net.lg

import android.util.Log
import com.irremote.tv.control.InputSource
import com.irremote.tv.control.TvApp
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
import org.json.JSONArray
import org.json.JSONObject
import java.util.concurrent.ConcurrentHashMap
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicInteger

/**
 * LG webOS remote (SSAP over WebSocket on :3000 / :3001) plus the pointer socket for buttons.
 * First connection shows an accept prompt on the TV; the client key is saved afterwards.
 */
class WebOsSession(
    override val tv: DiscoveredTv,
    private val store: PairingStore,
    private val client: OkHttpClient,
    private val wsPort: Int = 3000,
    private val wssPort: Int = 3001,
    private val approvalTimeoutMs: Long = 60_000,
    private val requestTimeoutMs: Long = 5_000
) : RemoteSession {

    @Volatile private var main: WebSocket? = null
    @Volatile private var pointer: WebSocket? = null
    @Volatile private var registered = false
    private val ids = AtomicInteger(1)
    private val pending = ConcurrentHashMap<String, CompletableResponse>()

    override val isOpen: Boolean get() = registered && main != null
    override val supportsText: Boolean = true

    private class CompletableResponse {
        val latch = CountDownLatch(1)
        @Volatile var value: JSONObject? = null
    }

    fun open(prompt: PromptListener?) {
        close()
        val errors = ArrayList<String>()
        for ((scheme, port) in listOf("ws" to wsPort, "wss" to wssPort)) {
            val error = tryOpen(scheme, port, prompt) ?: return
            errors += "$scheme:$port $error"
            if (error.startsWith(DENIED)) break
        }
        throw IllegalStateException("LG TV: ${errors.joinToString("; ")}")
    }

    private fun tryOpen(scheme: String, port: Int, prompt: PromptListener?): String? {
        val done = CountDownLatch(1)
        var failure: String? = "no response"
        val listener = object : WebSocketListener() {
            override fun onOpen(webSocket: WebSocket, response: Response) {
                webSocket.send(registrationMessage(store.lgClientKey(tv.ip)).toString())
            }

            override fun onMessage(webSocket: WebSocket, text: String) {
                val json = runCatching { JSONObject(text) }.getOrNull() ?: return
                val id = json.optString("id")
                when (json.optString("type")) {
                    "registered" -> {
                        json.optJSONObject("payload")?.optString("client-key")?.takeIf { it.isNotBlank() }?.let {
                            store.setLgClientKey(tv.ip, it)
                        }
                        registered = true
                        failure = null
                        done.countDown()
                    }
                    "response" -> {
                        if (id == REGISTER_ID) {
                            if (json.optJSONObject("payload")?.optString("pairingType") == "PROMPT") {
                                prompt?.onPrompt("Accept the connection prompt on your LG TV")
                            }
                        } else {
                            pending.remove(id)?.let { it.value = json; it.latch.countDown() }
                        }
                    }
                    "error" -> {
                        if (id == REGISTER_ID) {
                            failure = "$DENIED (${json.optString("error")})"
                            done.countDown()
                        } else {
                            pending.remove(id)?.let { it.value = json; it.latch.countDown() }
                        }
                    }
                }
            }

            override fun onFailure(webSocket: WebSocket, t: Throwable, response: Response?) {
                registered = false
                if (done.count > 0) {
                    failure = t.message ?: "connection failed"
                    done.countDown()
                }
            }

            override fun onClosed(webSocket: WebSocket, code: Int, reason: String) {
                registered = false
                if (done.count > 0) {
                    failure = "closed ($code $reason)"
                    done.countDown()
                }
            }
        }
        val ws = client.newWebSocket(Request.Builder().url("$scheme://${tv.ip}:$port").build(), listener)
        main = ws
        if (!done.await(approvalTimeoutMs, TimeUnit.MILLISECONDS)) failure = "no answer from TV"
        if (failure != null) {
            ws.cancel()
            main = null
            return failure
        }
        Log.i(TAG, "Registered with ${tv.ip} via $scheme:$port")
        openPointer()
        return null
    }

    private fun openPointer() {
        val response = request("ssap://com.webos.service.networkinput/getPointerInputSocket") ?: return
        val path = response.optJSONObject("payload")?.optString("socketPath")?.takeIf { it.isNotBlank() } ?: return
        val ready = CountDownLatch(1)
        pointer = client.newWebSocket(Request.Builder().url(path).build(), object : WebSocketListener() {
            override fun onOpen(webSocket: WebSocket, response: Response) { ready.countDown() }
            override fun onFailure(webSocket: WebSocket, t: Throwable, response: Response?) {
                pointer = null
                ready.countDown()
            }
            override fun onClosed(webSocket: WebSocket, code: Int, reason: String) { pointer = null }
        })
        ready.await(requestTimeoutMs, TimeUnit.MILLISECONDS)
    }

    /** Sends an SSAP request and waits for its response; null on timeout. */
    fun request(uri: String, payload: JSONObject? = null): JSONObject? {
        val ws = main ?: return null
        val id = "req_${ids.getAndIncrement()}"
        val slot = CompletableResponse()
        pending[id] = slot
        val msg = JSONObject().put("type", "request").put("id", id).put("uri", uri)
        if (payload != null) msg.put("payload", payload)
        if (!ws.send(msg.toString())) {
            pending.remove(id)
            return null
        }
        slot.latch.await(requestTimeoutMs, TimeUnit.MILLISECONDS)
        pending.remove(id)
        return slot.value
    }

    private fun ok(response: JSONObject?): Boolean =
        response != null && response.optString("type") == "response" &&
            response.optJSONObject("payload")?.optBoolean("returnValue", true) != false

    fun button(name: String): TransmitResult {
        if (!isOpen) return TransmitResult.Failed("LG TV disconnected — reconnect from Wi‑Fi")
        if (pointer == null) openPointer()
        val p = pointer ?: return TransmitResult.Failed("LG TV: button socket unavailable")
        return if (p.send("type:button\nname:$name\n\n")) TransmitResult.NETWORK_SENT
        else TransmitResult.Failed("LG TV: send failed")
    }

    private fun ssap(uri: String, payload: JSONObject? = null): TransmitResult {
        if (!isOpen) return TransmitResult.Failed("LG TV disconnected — reconnect from Wi‑Fi")
        return if (ok(request(uri, payload))) TransmitResult.NETWORK_SENT
        else TransmitResult.Failed("LG TV rejected $uri")
    }

    override fun send(command: RemoteCommand): TransmitResult = when (command) {
        RemoteCommand.POWER -> ssap("ssap://system/turnOff")
        RemoteCommand.INPUT -> {
            val launched = ssap("ssap://system.launcher/launch", JSONObject().put("id", "com.webos.app.inputpicker"))
            if (launched is TransmitResult.Sent) launched else button("INPUT_HUB")
        }
        else -> button(buttonFor(command))
    }

    override fun sendText(text: String): TransmitResult = when (text) {
        "\b" -> ssap("ssap://com.webos.service.ime/deleteCharacters", JSONObject().put("count", 1))
        "\n" -> ssap("ssap://com.webos.service.ime/sendEnterKey")
        else -> ssap("ssap://com.webos.service.ime/insertText", JSONObject().put("text", text).put("replace", 0))
    }

    override fun launchApp(app: TvApp): TransmitResult {
        val id = app.lgId ?: return super.launchApp(app)
        return ssap("ssap://system.launcher/launch", JSONObject().put("id", id))
    }

    override fun inputSources(): List<InputSource> = InputSource.entries

    override fun selectInput(source: InputSource): TransmitResult = when (source) {
        InputSource.INPUT_MENU -> send(RemoteCommand.INPUT)
        InputSource.SETTINGS -> button("MENU")
        else -> {
            val app = when (source) {
                InputSource.HDMI1 -> "com.webos.app.hdmi1"
                InputSource.HDMI2 -> "com.webos.app.hdmi2"
                InputSource.HDMI3 -> "com.webos.app.hdmi3"
                InputSource.HDMI4 -> "com.webos.app.hdmi4"
                else -> "com.webos.app.livetv"
            }
            ssap("ssap://system.launcher/launch", JSONObject().put("id", app))
        }
    }

    override fun close() {
        registered = false
        pointer?.close(1000, null)
        main?.close(1000, null)
        pointer = null
        main = null
    }

    companion object {
        private const val TAG = "WebOsSession"
        private const val DENIED = "access denied"
        private const val REGISTER_ID = "register_0"

        fun buttonFor(command: RemoteCommand): String = when (command) {
            RemoteCommand.POWER -> "POWER"
            RemoteCommand.MUTE -> "MUTE"
            RemoteCommand.VOL_UP -> "VOLUMEUP"
            RemoteCommand.VOL_DOWN -> "VOLUMEDOWN"
            RemoteCommand.CH_UP -> "CHANNELUP"
            RemoteCommand.CH_DOWN -> "CHANNELDOWN"
            RemoteCommand.UP -> "UP"
            RemoteCommand.DOWN -> "DOWN"
            RemoteCommand.LEFT -> "LEFT"
            RemoteCommand.RIGHT -> "RIGHT"
            RemoteCommand.OK -> "ENTER"
            RemoteCommand.HOME -> "HOME"
            RemoteCommand.BACK -> "BACK"
            RemoteCommand.MENU -> "MENU"
            RemoteCommand.INPUT -> "INPUT_HUB"
            RemoteCommand.DIGIT_0 -> "0"
            RemoteCommand.DIGIT_1 -> "1"
            RemoteCommand.DIGIT_2 -> "2"
            RemoteCommand.DIGIT_3 -> "3"
            RemoteCommand.DIGIT_4 -> "4"
            RemoteCommand.DIGIT_5 -> "5"
            RemoteCommand.DIGIT_6 -> "6"
            RemoteCommand.DIGIT_7 -> "7"
            RemoteCommand.DIGIT_8 -> "8"
            RemoteCommand.DIGIT_9 -> "9"
        }

        private const val SIGNATURE =
            "eyJhbGdvcml0aG0iOiJSU0EtU0hBMjU2Iiwia2V5SWQiOiJ0ZXN0LXNpZ25pbm" +
                "ctY2VydCIsInNpZ25hdHVyZVZlcnNpb24iOjF9.hrVRgjCwXVvE2OOSpDZ58hR" +
                "+59aFNwYDyjQgKk3auukd7pcegmE2CzPCa0bJ0ZsRAcKkCTJrWo5iDzNhMBWRy" +
                "aMOv5zWSrthlf7G128qvIlpMT0YNY+n/FaOHE73uLrS/g7swl3/qH/BGFG2Hu4" +
                "RlL48eb3lLKqTt2xKHdCs6Cd4RMfJPYnzgvI4BNrFUKsjkcu+WD4OO2A27Pq1n" +
                "50cMchmcaXadJhGrOqH5YmHdOCj5NSHzJYrsW0HPlpuAx/ECMeIZYDh6RMqaFM" +
                "2DXzdKX9NmmyqzJ3o/0lkk/N97gfVRLW5hA29yeAwaCViZNCP8iC9aO0q9fQoj" +
                "oa7NQnAtw=="

        private val MANIFEST_PERMISSIONS = listOf(
            "LAUNCH", "LAUNCH_WEBAPP", "APP_TO_APP", "CLOSE", "TEST_OPEN", "TEST_PROTECTED",
            "CONTROL_AUDIO", "CONTROL_DISPLAY", "CONTROL_INPUT_JOYSTICK", "CONTROL_INPUT_MEDIA_RECORDING",
            "CONTROL_INPUT_MEDIA_PLAYBACK", "CONTROL_INPUT_TV", "CONTROL_POWER", "CONTROL_TV_SCREEN",
            "READ_APP_STATUS", "READ_CURRENT_CHANNEL", "READ_INPUT_DEVICE_LIST", "READ_NETWORK_STATE",
            "READ_RUNNING_APPS", "READ_TV_CHANNEL_LIST", "WRITE_NOTIFICATION_TOAST", "READ_POWER_STATE",
            "READ_COUNTRY_INFO", "CONTROL_INPUT_TEXT", "CONTROL_MOUSE_AND_KEYBOARD", "READ_INSTALLED_APPS",
            "READ_SETTINGS"
        )

        private val SIGNED_PERMISSIONS = listOf(
            "TEST_SECURE", "CONTROL_INPUT_TEXT", "CONTROL_MOUSE_AND_KEYBOARD", "READ_INSTALLED_APPS",
            "READ_LGE_SDX", "READ_NOTIFICATIONS", "SEARCH", "WRITE_SETTINGS", "WRITE_NOTIFICATION_ALERT",
            "CONTROL_POWER", "READ_CURRENT_CHANNEL", "READ_RUNNING_APPS", "READ_UPDATE_INFO",
            "UPDATE_FROM_REMOTE_APP", "READ_LGE_TV_INPUT_EVENTS", "READ_TV_CURRENT_TIME"
        )

        /** Signed LG manifest used by every open‑source webOS client; newer TVs require it. */
        fun registrationMessage(clientKey: String?): JSONObject {
            val signed = JSONObject()
                .put("appId", "com.lge.test")
                .put("created", "20140509")
                .put("localizedAppNames", JSONObject()
                    .put("", "LG Remote App")
                    .put("ko-KR", "리모컨 앱")
                    .put("zxx-XX", "ЛГ Rэмotэ AПП"))
                .put("localizedVendorNames", JSONObject().put("", "LG Electronics"))
                .put("permissions", JSONArray(SIGNED_PERMISSIONS))
                .put("serial", "2f930e2d2cfe083771f68e4fe7bb07")
                .put("vendorId", "com.lge")
            val manifest = JSONObject()
                .put("appVersion", "1.1")
                .put("manifestVersion", 1)
                .put("permissions", JSONArray(MANIFEST_PERMISSIONS))
                .put("signatures", JSONArray().put(JSONObject().put("signature", SIGNATURE).put("signatureVersion", 1)))
                .put("signed", signed)
            val payload = JSONObject()
                .put("forcePairing", false)
                .put("manifest", manifest)
                .put("pairingType", "PROMPT")
            if (!clientKey.isNullOrBlank()) payload.put("client-key", clientKey)
            return JSONObject().put("type", "register").put("id", REGISTER_ID).put("payload", payload)
        }
    }
}
