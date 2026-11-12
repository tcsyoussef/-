package com.irremote.tv.net

import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.net.androidtv.ClientIdentity
import com.irremote.tv.net.samsung.SamsungSession
import okhttp3.Response
import okhttp3.WebSocket
import okhttp3.WebSocketListener
import okhttp3.mockwebserver.Dispatcher
import okhttp3.mockwebserver.MockResponse
import okhttp3.mockwebserver.MockWebServer
import okhttp3.mockwebserver.RecordedRequest
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config
import java.net.ServerSocket
import java.util.concurrent.CopyOnWriteArrayList
import java.util.concurrent.atomic.AtomicInteger

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [34])
class AutoConnectTest {
    private val servers = ArrayList<MockWebServer>()
    private val closers = ArrayList<AutoCloseable>()
    private val http = TrustAll.okHttp(3000)

    @After
    fun tearDown() {
        servers.forEach { runCatching { it.shutdown() } }
        closers.forEach { runCatching { it.close() } }
    }

    private fun rokuTv(paths: MutableList<String> = CopyOnWriteArrayList()) = MockWebServer().also {
        it.dispatcher = object : Dispatcher() {
            override fun dispatch(request: RecordedRequest): MockResponse {
                paths += "${request.method} ${request.path}"
                return MockResponse().setBody("<device-info><user-device-name>Living Room</user-device-name></device-info>")
            }
        }
        it.start()
        servers += it
    }

    /** A port that accepts TCP and hangs up straight away, like a TV service that is broken or busy. */
    private fun brokenPort(): Int {
        val server = ServerSocket(0)
        closers += server
        Thread {
            while (!server.isClosed) runCatching { server.accept().close() }
        }.apply { isDaemon = true }.start()
        return server.localPort
    }

    @Test
    fun fallsBackToTheNextPlatformWhenTheFirstFails() {
        val paths = CopyOnWriteArrayList<String>()
        val roku = rokuTv(paths)
        val wifi = WifiRemoteManager(
            InMemoryPairingStore(), identity = { ClientIdentity.generate() },
            ports = TvPorts(
                androidTvRemote = brokenPort(), androidTvPairing = brokenPort(),
                samsungWs = freePort(), samsungWss = freePort(), lgWs = freePort(), lgWss = freePort(),
                roku = roku.port, haierDiscover = freePort(), haierCommand = listOf(freePort()), cast = freePort()
            ),
            http = http
        )
        val tv = wifi.detect("127.0.0.1")!!
        assertEquals(TvProtocol.ANDROID_TV, tv.protocol)
        assertEquals(listOf(TvProtocol.ROKU), tv.alternatives)
        assertEquals("Living Room", tv.name)

        val outcome = wifi.connectIp("127.0.0.1", null)
        assertTrue(outcome.toString(), outcome is ConnectOutcome.Connected)
        assertEquals(TvProtocol.ROKU, wifi.connectedTv?.protocol)
        assertTrue(wifi.send(RemoteCommand.HOME) is TransmitResult.Sent)
        assertTrue(paths.contains("POST /keypress/Home"))
    }

    @Test
    fun reconnectsSilentlyWhenTheTvDropsTheConnection() {
        val connections = AtomicInteger()
        val keys = CopyOnWriteArrayList<String>()
        val samsung = MockWebServer().also {
            it.dispatcher = object : Dispatcher() {
                override fun dispatch(request: RecordedRequest): MockResponse =
                    MockResponse().withWebSocketUpgrade(object : WebSocketListener() {
                        override fun onOpen(webSocket: WebSocket, response: Response) {
                            connections.incrementAndGet()
                            webSocket.send("""{"event":"ms.channel.connect","data":{"token":"777"}}""")
                        }
                        override fun onMessage(webSocket: WebSocket, text: String) { keys += text }
                    })
            }
            it.start()
            servers += it
        }
        val wifi = WifiRemoteManager(
            InMemoryPairingStore(), identity = { error("unused") },
            ports = TvPorts(
                androidTvRemote = freePort(), androidTvPairing = freePort(),
                samsungWs = samsung.port, samsungWss = freePort(), lgWs = freePort(), lgWss = freePort(),
                roku = freePort(), haierDiscover = freePort(), haierCommand = listOf(freePort()), cast = freePort()
            ),
            http = http
        )
        assertTrue(wifi.connectIp("127.0.0.1", null) is ConnectOutcome.Connected)
        (wifi.session as SamsungSession).close()

        val result = wifi.send(RemoteCommand.VOL_UP)
        assertTrue(result.toString(), result is TransmitResult.Sent)
        assertEquals(2, connections.get())
        waitFor { keys.any { it.contains("KEY_VOLUP") } }
    }

    @Test
    fun findsTheSavedTvAgainAfterItsIpChanged() {
        val roku = rokuTv()
        val store = InMemoryPairingStore()
        store.setLastTv(DiscoveredTv("127.0.0.2", TvProtocol.ROKU, "Living Room"))
        val wifi = WifiRemoteManager(
            store, identity = { error("unused") },
            ports = TvPorts(
                androidTvRemote = freePort(), androidTvPairing = freePort(),
                samsungWs = freePort(), samsungWss = freePort(), lgWs = freePort(), lgWss = freePort(),
                roku = roku.port, haierDiscover = freePort(), haierCommand = listOf(freePort()), cast = freePort()
            ),
            http = http
        )
        val outcome = wifi.connectSaved(null) { listOf(DiscoveredTv("127.0.0.1", TvProtocol.ROKU, "Living Room")) }
        assertTrue(outcome.toString(), outcome is ConnectOutcome.Connected)
        assertEquals("127.0.0.1", store.lastTv()?.ip)
    }

    @Test
    fun samsungTokenSurvivesAnIpChange() {
        val store = InMemoryPairingStore()
        store.setSamsungToken("192.168.1.20", "abc")
        assertEquals("abc", store.samsungToken("192.168.1.31"))
        store.setLgClientKey("192.168.1.20", "key")
        assertEquals("key", store.lgClientKey("192.168.1.31"))
    }
}
