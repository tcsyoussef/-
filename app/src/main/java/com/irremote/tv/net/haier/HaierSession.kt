package com.irremote.tv.net.haier

import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.net.DiscoveredTv
import com.irremote.tv.net.RemoteSession
import com.irremote.tv.wifi.HaierWifiClient

/** Haier / Vestel SmartCenter (older Haier smart TVs that aren't Android TV). */
class HaierSession(
    override val tv: DiscoveredTv,
    private val client: HaierWifiClient
) : RemoteSession {

    override val isOpen: Boolean get() = client.isConnected

    fun open() {
        client.connect(tv.ip).getOrThrow()
    }

    override fun send(command: RemoteCommand): TransmitResult = client.send(command)

    override fun close() = client.disconnect()
}
