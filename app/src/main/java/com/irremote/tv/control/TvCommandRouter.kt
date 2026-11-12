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
        if (command == RemoteCommand.INPUT) return sendInput(brand, target)
        return target.send(command)
    }

    /**
     * Input, best method first: the TV's own SmartCenter Input key, then the phone's IR blaster
     * when the network key is unreliable (Google TV ignores it), then the network key.
     */
    private fun sendInput(brand: TvBrand, target: RemoteTarget): TransmitResult {
        target.sendNativeInput()?.takeIf { it is TransmitResult.Sent }?.let { return it }
        if (!target.inputKeyReliable && ir.hasBuiltInEmitter) {
            val viaIr = ir.transmit(brand, RemoteCommand.INPUT)
            if (viaIr is TransmitResult.Sent) return viaIr
        }
        return target.send(RemoteCommand.INPUT)
    }

    fun launchApp(app: TvApp): TransmitResult {
        if (link == ControlLink.IR) {
            return TransmitResult.Failed("Infrared can't open ${app.label}. Connect over Wi‑Fi to use app buttons.")
        }
        val target = target() ?: return TransmitResult.Failed("Not connected")
        return target.launchApp(app)
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
