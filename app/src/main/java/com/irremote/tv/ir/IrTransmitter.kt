package com.irremote.tv.ir

import android.content.Context
import android.hardware.ConsumerIrManager
import android.util.Log

sealed class TransmitResult {
    data class Sent(
        val pattern: IrPattern,
        val repeats: Int
    ) : TransmitResult()

    data class Failed(val reason: String) : TransmitResult()
}

interface IrTransmitter {
    val hasBuiltInEmitter: Boolean
    fun transmit(brand: TvBrand, command: RemoteCommand): TransmitResult
}

/**
 * Real IR transmitter using the phone's built-in IR blaster via [ConsumerIrManager].
 * Does not simulate success when hardware is missing — control requires a phone with IR.
 */
class AndroidIrTransmitter(
    context: Context,
    private val repeatCount: Int = 2
) : IrTransmitter {

    private val irManager: ConsumerIrManager? =
        context.getSystemService(Context.CONSUMER_IR_SERVICE) as? ConsumerIrManager

    override val hasBuiltInEmitter: Boolean
        get() = irManager?.hasIrEmitter() == true

    override fun transmit(brand: TvBrand, command: RemoteCommand): TransmitResult {
        val manager = irManager
        if (manager == null || !manager.hasIrEmitter()) {
            return TransmitResult.Failed(
                "This phone has no IR blaster. Install on a phone with built-in infrared to control your TV."
            )
        }

        val pattern = IrEncoder.encode(brand, command)
        if (!supportsFrequency(manager, pattern.frequencyHz)) {
            return TransmitResult.Failed(
                "IR blaster does not support ${pattern.frequencyHz / 1000} kHz carrier needed for ${brand.displayName}."
            )
        }

        return try {
            val repeats = repeatCount.coerceAtLeast(1)
            repeat(repeats) { index ->
                manager.transmit(pattern.frequencyHz, pattern.patternMicros)
                if (index < repeats - 1) {
                    Thread.sleep(40)
                }
            }
            Log.i(TAG, "IR TX ${brand.displayName} ${command.label} @ ${pattern.frequencyHz}Hz x$repeats")
            TransmitResult.Sent(pattern, repeats = repeats)
        } catch (error: Exception) {
            TransmitResult.Failed(error.message ?: "IR transmit failed")
        }
    }

    private fun supportsFrequency(manager: ConsumerIrManager, frequencyHz: Int): Boolean {
        val ranges = manager.carrierFrequencies ?: return true
        if (ranges.isEmpty()) return true
        return ranges.any { frequencyHz in it.minFrequency..it.maxFrequency }
    }

    companion object {
        private const val TAG = "IrTransmitter"
    }
}
