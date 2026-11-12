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
}
