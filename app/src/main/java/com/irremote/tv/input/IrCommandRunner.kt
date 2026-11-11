package com.irremote.tv.input

import android.os.Handler
import android.os.Looper
import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.ir.TvBrand

/**
 * Sends a sequence of commands with spacing so the TV can process each step.
 */
class IrCommandRunner(
    private val sender: (TvBrand, RemoteCommand) -> TransmitResult,
    private val gapMs: Long = 120L,
    private val handler: Handler = Handler(Looper.getMainLooper())
) {
    private var queued = false

    fun enqueue(
        brand: TvBrand,
        commands: List<RemoteCommand>,
        onEach: ((RemoteCommand, TransmitResult) -> Unit)? = null,
        onDone: (() -> Unit)? = null
    ) {
        if (commands.isEmpty()) {
            onDone?.invoke()
            return
        }
        queued = true
        sendNext(brand, commands, 0, onEach, onDone)
    }

    fun isBusy(): Boolean = queued

    private fun sendNext(
        brand: TvBrand,
        commands: List<RemoteCommand>,
        index: Int,
        onEach: ((RemoteCommand, TransmitResult) -> Unit)?,
        onDone: (() -> Unit)?
    ) {
        if (index >= commands.size) {
            queued = false
            onDone?.invoke()
            return
        }
        val command = commands[index]
        val result = sender(brand, command)
        onEach?.invoke(command, result)
        if (result is TransmitResult.Failed) {
            queued = false
            onDone?.invoke()
            return
        }
        handler.postDelayed({
            sendNext(brand, commands, index + 1, onEach, onDone)
        }, gapMs)
    }
}
