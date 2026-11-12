package com.irremote.tv.wifi

import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test

/**
 * Mock Vestel/Haier SmartCenter TV against ephemeral ports.
 */
class HaierWifiClientIntegrationTest {

    private lateinit var server: MockSmartCenterServer
    private lateinit var client: HaierWifiClient

    @Before
    fun setUp() {
        server = MockSmartCenterServer()
        server.start()
        client = HaierWifiClient(
            discoverPort = server.discoverPort,
            commandPorts = intArrayOf(server.commandPort)
        )
    }

    @After
    fun tearDown() {
        server.stop()
    }

    @Test
    fun connect_readsDdXmlAndDetectsCommandPort() {
        val result = client.connect("127.0.0.1")
        assertTrue("connect failed: ${result.exceptionOrNull()?.message}", result.isSuccess)
        val device = result.getOrThrow()
        assertEquals("Mock Haier TV", device.name)
        assertEquals("LE55U7000UG", device.model)
        assertEquals(server.commandPort, device.portCommand)
        assertTrue(client.isConnected)
    }

    @Test
    fun send_homeMenuInput_postsCorrectVestelBodies() {
        assertTrue(client.connect("127.0.0.1").isSuccess)
        server.receivedBodies.clear()

        assertTrue(client.send(RemoteCommand.HOME) is TransmitResult.Sent)
        assertTrue(client.send(RemoteCommand.MENU) is TransmitResult.Sent)
        assertTrue(client.send(RemoteCommand.INPUT) is TransmitResult.Sent)

        // Haier V300S body is tried first and accepted by the mock
        assertTrue(server.receivedBodies.any { it.contains("code='1048'") })
        assertTrue(server.receivedBodies.any { it.contains("code='1066'") })
        assertTrue(server.receivedBodies.any { it.contains("code='1056'") })
        assertTrue(
            server.receivedBodies.any {
                it == "<?xml version='1.0' ?><remote><key code='1048'/><?xml version='1.0' ?>"
            }
        )
        assertTrue(
            server.receivedContentTypes.any { it.contains("ISO-8859-1", ignoreCase = true) }
        )
    }

    @Test
    fun postKey_acceptsHttp404LikeSomeVestelFirmwares() {
        server.setCommandStatus(404)
        assertTrue(client.postKey("127.0.0.1", 1012, server.commandPort))
    }

    @Test
    fun postKey_rejectsWhenSmartCenterReturnsError() {
        server.setCommandStatus(500)
        val ok = client.postKey("127.0.0.1", 1048, server.commandPort)
        assertEquals(false, ok)
    }
}
