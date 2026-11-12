package com.irremote.tv.control

import com.irremote.tv.ir.IrPattern
import com.irremote.tv.ir.IrTransmitter
import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.ir.TvBrand
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class FakeIr(
    override val hasBuiltInEmitter: Boolean = true
) : IrTransmitter {
    var last: RemoteCommand? = null
    override fun transmit(brand: TvBrand, command: RemoteCommand): TransmitResult {
        last = command
        return TransmitResult.Sent(IrPattern(38000, intArrayOf(1, 1)), 1)
    }
}

class FakeTarget(
    override var isReady: Boolean = false,
    override val supportsText: Boolean = true
) : RemoteTarget {
    val sent = ArrayList<RemoteCommand>()
    val typed = StringBuilder()
    override fun send(command: RemoteCommand): TransmitResult {
        if (!isReady) return TransmitResult.Failed("not connected")
        sent += command
        return TransmitResult.NETWORK_SENT
    }

    override fun sendText(text: String): TransmitResult {
        typed.append(text)
        return TransmitResult.NETWORK_SENT
    }
}

class TvCommandRouterTest {
    @Test
    fun defaultsToIr() {
        val router = TvCommandRouter(FakeIr(), FakeTarget())
        assertEquals(ControlLink.IR, router.link)
        assertTrue(router.statusReady())
        assertFalse(router.supportsText())
    }

    @Test
    fun irPath_forwardsCommand() {
        val ir = FakeIr()
        val router = TvCommandRouter(ir, FakeTarget())
        router.send(TvBrand.HAIER, RemoteCommand.POWER)
        assertEquals(RemoteCommand.POWER, ir.last)
    }

    @Test
    fun wifiPath_failsWhenNotConnected() {
        val router = TvCommandRouter(FakeIr(), FakeTarget())
        router.link = ControlLink.WIFI
        assertTrue(router.send(TvBrand.HAIER, RemoteCommand.MUTE) is TransmitResult.Failed)
        assertFalse(router.statusReady())
    }

    @Test
    fun wifiPath_sendsKeysAndText() {
        val wifi = FakeTarget(isReady = true)
        val router = TvCommandRouter(FakeIr(), wifi)
        router.link = ControlLink.WIFI
        assertTrue(router.send(TvBrand.HAIER, RemoteCommand.HOME) is TransmitResult.Sent)
        assertTrue(router.supportsText())
        router.sendText("abc")
        assertEquals(listOf(RemoteCommand.HOME), wifi.sent)
        assertEquals("abc", wifi.typed.toString())
    }

    @Test
    fun bluetoothPath_usesBluetoothTarget() {
        val bt = FakeTarget(isReady = true)
        val router = TvCommandRouter(FakeIr(), FakeTarget(), bt)
        router.link = ControlLink.BLUETOOTH
        router.send(TvBrand.HAIER, RemoteCommand.BACK)
        assertEquals(listOf(RemoteCommand.BACK), bt.sent)
    }

    @Test
    fun bluetoothPath_failsWithoutSupport() {
        val router = TvCommandRouter(FakeIr(), FakeTarget(), null)
        router.link = ControlLink.BLUETOOTH
        assertTrue(router.send(TvBrand.HAIER, RemoteCommand.BACK) is TransmitResult.Failed)
    }

    private class InputTarget(
        override val inputKeyReliable: Boolean,
        private val native: TransmitResult? = null
    ) : RemoteTarget {
        override val isReady = true
        override val supportsText = false
        val sent = ArrayList<RemoteCommand>()
        override fun send(command: RemoteCommand): TransmitResult {
            sent += command
            return TransmitResult.NETWORK_SENT
        }
        override fun sendNativeInput(): TransmitResult? = native
    }

    @Test
    fun input_prefersTheTvsNativeInputChannel() {
        val ir = FakeIr()
        val wifi = InputTarget(inputKeyReliable = false, native = TransmitResult.NETWORK_SENT)
        val router = TvCommandRouter(ir, wifi).apply { link = ControlLink.WIFI }
        assertTrue(router.send(TvBrand.HAIER, RemoteCommand.INPUT) is TransmitResult.Sent)
        assertEquals(null, ir.last)
        assertTrue(wifi.sent.isEmpty())
    }

    @Test
    fun input_usesIrWhenTheNetworkKeyIsUnreliable() {
        val ir = FakeIr()
        val wifi = InputTarget(inputKeyReliable = false)
        val router = TvCommandRouter(ir, wifi).apply { link = ControlLink.WIFI }
        assertTrue(router.send(TvBrand.HAIER, RemoteCommand.INPUT) is TransmitResult.Sent)
        assertEquals(RemoteCommand.INPUT, ir.last)
        assertTrue(wifi.sent.isEmpty())
    }

    @Test
    fun input_staysOnTheNetworkWhenItIsReliableOrThereIsNoIr() {
        val samsung = InputTarget(inputKeyReliable = true)
        val ir = FakeIr()
        TvCommandRouter(ir, samsung).apply { link = ControlLink.WIFI }.send(TvBrand.HAIER, RemoteCommand.INPUT)
        assertEquals(listOf(RemoteCommand.INPUT), samsung.sent)
        assertEquals(null, ir.last)

        val googleTv = InputTarget(inputKeyReliable = false)
        TvCommandRouter(FakeIr(hasBuiltInEmitter = false), googleTv).apply { link = ControlLink.WIFI }
            .send(TvBrand.HAIER, RemoteCommand.INPUT)
        assertEquals(listOf(RemoteCommand.INPUT), googleTv.sent)
    }
}
