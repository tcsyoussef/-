package com.irremote.tv.net

import com.irremote.tv.control.TvApp
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.net.androidtv.ClientIdentity
import com.irremote.tv.net.roku.RokuSession
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
import java.util.concurrent.CopyOnWriteArrayList

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [34])
class LaunchAppTest {
    private val servers = ArrayList<MockWebServer>()
    private val http = TrustAll.okHttp(3000)

    @After fun tearDown() = servers.forEach { runCatching { it.shutdown() } }

    @Test
    fun rokuLaunchesNetflixAndYoutube() {
        val paths = CopyOnWriteArrayList<String>()
        val tv = MockWebServer().also {
            it.dispatcher = object : Dispatcher() {
                override fun dispatch(request: RecordedRequest): MockResponse {
                    paths += "${request.method} ${request.path}"
                    return MockResponse()
                }
            }
            it.start(); servers += it
        }
        val session = RokuSession(DiscoveredTv("127.0.0.1", TvProtocol.ROKU, "Roku"), http, tv.port)
        assertTrue(session.launchApp(TvApp.NETFLIX) is TransmitResult.Sent)
        assertTrue(session.launchApp(TvApp.YOUTUBE) is TransmitResult.Sent)
        assertTrue(session.launchApp(TvApp.DISNEY_PLUS) is TransmitResult.Sent)
        assertEquals(
            listOf("POST /launch/12", "POST /launch/837", "POST /launch/291097"),
            paths.toList()
        )
    }

    @Test
    fun androidTvSendsAppLink() {
        MockAndroidTv().use { tv ->
            val wifi = WifiRemoteManager(
                InMemoryPairingStore(), { ClientIdentity.generate() },
                ports = TvPorts(
                    androidTvRemote = tv.remotePort, androidTvPairing = tv.pairingPort,
                    samsungWs = freePort(), samsungWss = freePort(), lgWs = freePort(), lgWss = freePort(),
                    roku = freePort(), haierDiscover = freePort(), haierCommand = listOf(freePort()), cast = freePort()
                )
            )
            val pin = wifi.connectIp("127.0.0.1", null) as ConnectOutcome.NeedsPin
            assertTrue(pin.submit(tv.shownCode!!) is ConnectOutcome.Connected)
            assertTrue(wifi.launchApp(TvApp.YOUTUBE) is TransmitResult.Sent)
            waitFor { tv.appLinks.isNotEmpty() }
            assertEquals(listOf("https://www.youtube.com"), tv.appLinks.toList())
        }
    }
}
