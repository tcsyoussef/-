package com.irremote.tv.ir

import android.content.Context
import android.hardware.ConsumerIrManager
import android.util.Log

sealed class TransmitResult {
    data class Sent(val pattern: IrPattern, val simulated: Boolean) : TransmitResult()
    data class Failed(val reason: String) : TransmitResult()
}

interface IrTransmitter {
    val hasBuiltInEmitter: Boolean
    val supportsUsbIrAdapter: Boolean
    fun transmit(brand: TvBrand, command: RemoteCommand): TransmitResult
}

class AndroidIrTransmitter(
    context: Context
) : IrTransmitter {

    private val irManager: ConsumerIrManager? =
        context.getSystemService(Context.CONSUMER_IR_SERVICE) as? ConsumerIrManager

    override val hasBuiltInEmitter: Boolean
        get() = irManager?.hasIrEmitter() == true

    /**
     * USB-C IR dongle support is intentionally reported as unavailable/untested.
     * No vendor-specific USB protocol is implemented or verified in this build.
     */
    override val supportsUsbIrAdapter: Boolean = false

    override fun transmit(brand: TvBrand, command: RemoteCommand): TransmitResult {
        val pattern = IrEncoder.encode(brand, command)
        return try {
            if (hasBuiltInEmitter) {
                irManager?.transmit(pattern.frequencyHz, pattern.patternMicros)
                TransmitResult.Sent(pattern, simulated = false)
            } else {
                Log.i(TAG, "Simulating IR ${brand.displayName} ${command.label} @ ${pattern.frequencyHz}Hz")
                TransmitResult.Sent(pattern, simulated = true)
            }
        } catch (error: Exception) {
            TransmitResult.Failed(error.message ?: "IR transmit failed")
        }
    }

    companion object {
        private const val TAG = "IrTransmitter"
    }
}
