package com.irremote.tv.control

import com.irremote.tv.ir.IrTransmitter
import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.ir.TvBrand

/**
 * Routes remote commands to the IR blaster, the active Wi‑Fi TV session, or Bluetooth HID.
 */
class TvCommandRouter(
    private val ir: IrTransmitter,
    private val wifi: RemoteTarget,
    private val bluetooth: RemoteTarget? = null
) {
    @Volatile
    var link: ControlLink = ControlLink.IR

    private fun target(): RemoteTarget? = when (link) {
        ControlLink.IR -> null
        ControlLink.WIFI -> wifi
        ControlLink.BLUETOOTH -> bluetooth
    }

    fun send(brand: TvBrand, command: RemoteCommand): TransmitResult {
        if (link == ControlLink.IR) return ir.transmit(brand, command)
        val target = target()
            ?: return TransmitResult.Failed("Bluetooth remote needs Android 9 or newer")
        return target.send(command)
    }

    fun inputSources(): List<InputSource> = when (link) {
        ControlLink.IR -> listOf(InputSource.INPUT_MENU)
        else -> target()?.inputSources().orEmpty()
    }

    fun selectInput(brand: TvBrand, source: InputSource): TransmitResult {
        if (link == ControlLink.IR) return ir.transmit(brand, RemoteCommand.INPUT)
        val target = target() ?: return TransmitResult.Failed("Not connected")
        return target.selectInput(source)
    }

    fun supportsText(): Boolean = target()?.let { it.isReady && it.supportsText } ?: false

    fun sendText(text: String): TransmitResult =
        target()?.sendText(text) ?: TransmitResult.Failed("Typing needs Wi‑Fi or Bluetooth")

    fun statusReady(): Boolean = when (link) {
        ControlLink.IR -> ir.hasBuiltInEmitter
        else -> target()?.isReady == true
    }
}
