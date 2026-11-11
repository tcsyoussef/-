package com.irremote.tv.control

import com.irremote.tv.ir.IrPattern
import com.irremote.tv.ir.IrTransmitter
import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.ir.TvBrand
import com.irremote.tv.wifi.HaierWifiClient
import org.junit.Assert.assertEquals
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

class TvCommandRouterTest {
    @Test
    fun defaultsToIr() {
        val router = TvCommandRouter(FakeIr(), HaierWifiClient())
        assertEquals(ControlLink.IR, router.link)
        assertTrue(router.statusReady())
    }

    @Test
    fun irPath_forwardsCommand() {
        val ir = FakeIr()
        val router = TvCommandRouter(ir, HaierWifiClient())
        router.link = ControlLink.IR
        router.send(TvBrand.HAIER, RemoteCommand.POWER)
        assertEquals(RemoteCommand.POWER, ir.last)
    }

    @Test
    fun wifiPath_failsWhenNotConnected() {
        val router = TvCommandRouter(FakeIr(), HaierWifiClient())
        router.link = ControlLink.WIFI
        val result = router.send(TvBrand.HAIER, RemoteCommand.MUTE)
        assertTrue(result is TransmitResult.Failed)
    }
}
