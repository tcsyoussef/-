package com.irremote.tv.control

import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult

/**
 * A non‑IR control path (Wi‑Fi TV session or Bluetooth HID).
 *
 * [sendText] accepts printable text plus two control characters:
 * `'\b'` = delete one character, `'\n'` = Enter.
 */
interface RemoteTarget {
    val isReady: Boolean
    val supportsText: Boolean
    fun send(command: RemoteCommand): TransmitResult
    fun sendText(text: String): TransmitResult =
        TransmitResult.Failed("Typing is not supported on this connection")

    /** Sources offered in the Input picker; an empty list means Input switching isn't possible. */
    fun inputSources(): List<InputSource> = listOf(InputSource.INPUT_MENU)

    fun selectInput(source: InputSource): TransmitResult =
        if (source == InputSource.INPUT_MENU) send(RemoteCommand.INPUT)
        else TransmitResult.Failed("${source.label} isn't available on this TV")
}
