package com.irremote.tv.ir

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class FakeIrTransmitter(
    override val hasBuiltInEmitter: Boolean
) : IrTransmitter {
    var lastBrand: TvBrand? = null
    var lastCommand: RemoteCommand? = null

    override fun transmit(brand: TvBrand, command: RemoteCommand): TransmitResult {
        lastBrand = brand
        lastCommand = command
        if (!hasBuiltInEmitter) {
            return TransmitResult.Failed("This phone has no IR blaster.")
        }
        val pattern = IrEncoder.encode(brand, command)
        return TransmitResult.Sent(pattern, repeats = 2)
    }
}

class IrTransmitterTest {

    @Test
    fun withoutEmitter_failsInsteadOfSimulating() {
        val tx = FakeIrTransmitter(hasBuiltInEmitter = false)
        val result = tx.transmit(TvBrand.HAIER, RemoteCommand.POWER)
        assertTrue(result is TransmitResult.Failed)
        assertFalse(tx.hasBuiltInEmitter)
    }

    @Test
    fun withEmitter_sendsHaierPower() {
        val tx = FakeIrTransmitter(hasBuiltInEmitter = true)
        val result = tx.transmit(TvBrand.HAIER, RemoteCommand.POWER) as TransmitResult.Sent
        assertEquals(2, result.repeats)
        assertEquals(38_000, result.pattern.frequencyHz)
        assertEquals(RemoteCommand.POWER, tx.lastCommand)
        assertEquals(TvBrand.HAIER, tx.lastBrand)
    }
}
