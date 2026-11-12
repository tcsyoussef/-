package com.irremote.tv.net

import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult

/** An open control connection to one TV. */
interface RemoteSession {
    val tv: DiscoveredTv
    val isOpen: Boolean
    val supportsText: Boolean get() = false
    fun send(command: RemoteCommand): TransmitResult
    fun sendText(text: String): TransmitResult =
        TransmitResult.Failed("${tv.protocol.displayName} does not support typing")
    fun close()
}

/** Shown to the user while a TV waits for confirmation (Samsung "Allow", LG prompt). */
fun interface PromptListener {
    fun onPrompt(message: String)
}

sealed class ConnectOutcome {
    data class Connected(val session: RemoteSession) : ConnectOutcome()

    /** Android TV shows a 6‑character code; call [submit] with it from a background thread. */
    class NeedsPin(
        val tv: DiscoveredTv,
        val error: String? = null,
        val submit: (String) -> ConnectOutcome,
        val cancel: () -> Unit
    ) : ConnectOutcome()

    data class Failed(val reason: String) : ConnectOutcome()
}

class NeedsPairingException(message: String) : Exception(message)
