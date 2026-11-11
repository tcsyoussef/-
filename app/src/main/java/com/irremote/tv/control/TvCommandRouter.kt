package com.irremote.tv.control

import com.irremote.tv.ir.IrTransmitter
import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.ir.TvBrand
import com.irremote.tv.wifi.HaierWifiClient

/**
 * Routes remote commands to IR blaster or Haier Wi‑Fi LAN API.
 */
class TvCommandRouter(
    private val ir: IrTransmitter,
    private val wifi: HaierWifiClient
) {
    @Volatile
    var link: ControlLink = ControlLink.IR

    fun send(brand: TvBrand, command: RemoteCommand): TransmitResult {
        return when (link) {
            ControlLink.IR -> ir.transmit(brand, command)
            ControlLink.WIFI -> wifi.send(command)
        }
    }

    fun statusReady(): Boolean = when (link) {
        ControlLink.IR -> ir.hasBuiltInEmitter
        ControlLink.WIFI -> wifi.isConnected
    }
}
