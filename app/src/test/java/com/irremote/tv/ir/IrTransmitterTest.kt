package com.irremote.tv.ir

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class FakeIrTransmitter(
    override val hasBuiltInEmitter: Boolean = false,
    override val supportsUsbIrAdapter: Boolean = false
) : IrTransmitter {
    var lastBrand: TvBrand? = null
    var lastCommand: RemoteCommand? = null

    override fun transmit(brand: TvBrand, command: RemoteCommand): TransmitResult {
        lastBrand = brand
        lastCommand = command
        val pattern = IrEncoder.encode(brand, command)
        return TransmitResult.Sent(pattern, simulated = !hasBuiltInEmitter)
    }
}

class IrTransmitterTest {

    @Test
    fun fakeTransmitter_simulatesWithoutEmitter() {
        val tx = FakeIrTransmitter(hasBuiltInEmitter = false)
        val result = tx.transmit(TvBrand.SAMSUNG, RemoteCommand.MUTE)
        assertTrue(result is TransmitResult.Sent)
        val sent = result as TransmitResult.Sent
        assertTrue(sent.simulated)
        assertEquals(RemoteCommand.MUTE, tx.lastCommand)
        assertFalse(tx.supportsUsbIrAdapter)
    }

    @Test
    fun fakeTransmitter_marksHardwarePathWhenEmitterPresent() {
        val tx = FakeIrTransmitter(hasBuiltInEmitter = true)
        val result = tx.transmit(TvBrand.SONY, RemoteCommand.POWER) as TransmitResult.Sent
        assertFalse(result.simulated)
        assertEquals(40_000, result.pattern.frequencyHz)
    }
}
