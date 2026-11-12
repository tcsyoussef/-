package com.irremote.tv.net.roku

import com.irremote.tv.control.InputSource
import com.irremote.tv.control.TvApp
import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.net.DiscoveredTv
import com.irremote.tv.net.RemoteSession
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import java.net.URLEncoder

/** Roku External Control Protocol (HTTP on :8060). No pairing needed. */
class RokuSession(
    override val tv: DiscoveredTv,
    private val client: OkHttpClient,
    private val port: Int = 8060
) : RemoteSession {

    override val isOpen: Boolean = true
    override val supportsText: Boolean = true

    fun keypress(key: String): TransmitResult = try {
        val request = Request.Builder()
            .url("http://${tv.ip}:$port/keypress/$key")
            .post(ByteArray(0).toRequestBody(null))
            .build()
        client.newCall(request).execute().use { response ->
            if (response.isSuccessful) TransmitResult.NETWORK_SENT
            else TransmitResult.Failed("Roku rejected $key (HTTP ${response.code})")
        }
    } catch (error: Exception) {
        TransmitResult.Failed("Roku: ${error.message ?: "not reachable"}")
    }

    override fun send(command: RemoteCommand): TransmitResult = keypress(keyFor(command))

    override fun sendText(text: String): TransmitResult {
        if (text == "\b") return keypress("Backspace")
        if (text == "\n") return keypress("Enter")
        for (ch in text) {
            val result = keypress("Lit_" + URLEncoder.encode(ch.toString(), "UTF-8").replace("+", "%20"))
            if (result is TransmitResult.Failed) return result
        }
        return TransmitResult.NETWORK_SENT
    }

    override fun launchApp(app: TvApp): TransmitResult {
        val id = app.rokuId ?: return super.launchApp(app)
        return try {
            val request = Request.Builder()
                .url("http://${tv.ip}:$port/launch/$id")
                .post(ByteArray(0).toRequestBody(null))
                .build()
            client.newCall(request).execute().use { response ->
                if (response.isSuccessful) TransmitResult.NETWORK_SENT
                else TransmitResult.Failed("${app.label} isn't installed on this Roku")
            }
        } catch (error: Exception) {
            TransmitResult.Failed("Roku: ${error.message ?: "not reachable"}")
        }
    }

    override fun inputSources(): List<InputSource> = listOf(
        InputSource.HDMI1, InputSource.HDMI2, InputSource.HDMI3, InputSource.HDMI4, InputSource.TV
    )

    override fun selectInput(source: InputSource): TransmitResult = keypress(
        when (source) {
            InputSource.HDMI1 -> "InputHDMI1"
            InputSource.HDMI2 -> "InputHDMI2"
            InputSource.HDMI3 -> "InputHDMI3"
            InputSource.HDMI4 -> "InputHDMI4"
            InputSource.TV -> "InputTuner"
            else -> "Home"
        }
    )

    override fun close() = Unit

    companion object {
        fun keyFor(command: RemoteCommand): String = when (command) {
            RemoteCommand.POWER -> "Power"
            RemoteCommand.MUTE -> "VolumeMute"
            RemoteCommand.VOL_UP -> "VolumeUp"
            RemoteCommand.VOL_DOWN -> "VolumeDown"
            RemoteCommand.CH_UP -> "ChannelUp"
            RemoteCommand.CH_DOWN -> "ChannelDown"
            RemoteCommand.UP -> "Up"
            RemoteCommand.DOWN -> "Down"
            RemoteCommand.LEFT -> "Left"
            RemoteCommand.RIGHT -> "Right"
            RemoteCommand.OK -> "Select"
            RemoteCommand.HOME -> "Home"
            RemoteCommand.BACK -> "Back"
            RemoteCommand.MENU -> "Info"
            RemoteCommand.INPUT -> "InputHDMI1"
            RemoteCommand.DIGIT_0 -> "Lit_0"
            RemoteCommand.DIGIT_1 -> "Lit_1"
            RemoteCommand.DIGIT_2 -> "Lit_2"
            RemoteCommand.DIGIT_3 -> "Lit_3"
            RemoteCommand.DIGIT_4 -> "Lit_4"
            RemoteCommand.DIGIT_5 -> "Lit_5"
            RemoteCommand.DIGIT_6 -> "Lit_6"
            RemoteCommand.DIGIT_7 -> "Lit_7"
            RemoteCommand.DIGIT_8 -> "Lit_8"
            RemoteCommand.DIGIT_9 -> "Lit_9"
        }
    }
}
