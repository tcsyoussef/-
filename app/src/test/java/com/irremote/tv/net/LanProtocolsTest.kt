package com.irremote.tv.net

import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.net.lg.WebOsSession
import com.irremote.tv.net.roku.RokuSession
import com.irremote.tv.net.samsung.SamsungSession
import okhttp3.Response
import okhttp3.WebSocket
import okhttp3.WebSocketListener
import okhttp3.mockwebserver.Dispatcher
import okhttp3.mockwebserver.MockResponse
import okhttp3.mockwebserver.MockWebServer
import okhttp3.mockwebserver.RecordedRequest
import org.json.JSONObject
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test
import java.util.Base64
import java.util.concurrent.CopyOnWriteArrayList

class LanProtocolsTest {
    private val servers = ArrayList<MockWebServer>()
    private val http = TrustAll.okHttp(3000)
    private val b64: (String) -> String = { Base64.getEncoder().encodeToString(it.toByteArray()) }

    private fun server(dispatcher: Dispatcher) = MockWebServer().also {
        it.dispatcher = dispatcher
        it.start()
        servers += it
    }

    @After
    fun tearDown() = servers.forEach { runCatching { it.shutdown() } }

    // ---------------------------------------------------------------- Samsung

    private class SamsungTv(val allow: Boolean) : Dispatcher() {
        val messages = CopyOnWriteArrayList<JSONObject>()
        val urls = CopyOnWriteArrayList<String>()
        override fun dispatch(request: RecordedRequest): MockResponse {
            urls += request.path.orEmpty()
            return MockResponse().withWebSocketUpgrade(object : WebSocketListener() {
                override fun onOpen(webSocket: WebSocket, response: Response) {
                    webSocket.send(
                        if (allow) """{"event":"ms.channel.connect","data":{"token":"55555"}}"""
                        else """{"event":"ms.channel.unauthorized"}"""
                    )
                }
                override fun onMessage(webSocket: WebSocket, text: String) { messages += JSONObject(text) }
            })
        }
    }

    @Test
    fun samsung_allowStoresTokenAndSendsKeys() {
        val tvLogic = SamsungTv(allow = true)
        val tv = server(tvLogic)
        val store = InMemoryPairingStore()
        val prompts = ArrayList<String>()
        val session = SamsungSession(
            DiscoveredTv("127.0.0.1", TvProtocol.SAMSUNG, "Samsung"), store, http,
            wssPort = freePort(), wsPort = tv.port, approvalTimeoutMs = 3000, base64 = b64
        )
        session.open { prompts += it }
        assertTrue(session.isOpen)
        assertEquals("55555", store.samsungToken("127.0.0.1"))
        assertTrue(prompts.isNotEmpty())
        assertTrue(tvLogic.urls.first().contains("name=" + b64("IR TV Remote")))

        listOf(RemoteCommand.HOME, RemoteCommand.INPUT, RemoteCommand.MENU, RemoteCommand.BACK).forEach {
            assertTrue(session.send(it) is TransmitResult.Sent)
        }
        session.sendText("abc")
        waitFor { tvLogic.messages.size >= 6 }
        val keys = tvLogic.messages.mapNotNull { it.optJSONObject("params") }
            .filter { it.optString("TypeOfRemote") == "SendRemoteKey" }.map { it.getString("DataOfCmd") }
        assertEquals(listOf("KEY_HOME", "KEY_SOURCE", "KEY_MENU", "KEY_RETURN"), keys)
        val text = tvLogic.messages.mapNotNull { it.optJSONObject("params") }
            .first { it.optString("TypeOfRemote") == "SendInputString" }
        assertEquals(b64("abc"), text.getString("Cmd"))
        session.close()

        // Second connect reuses the token
        val again = SamsungSession(
            DiscoveredTv("127.0.0.1", TvProtocol.SAMSUNG, "Samsung"), store, http,
            wssPort = freePort(), wsPort = tv.port, approvalTimeoutMs = 3000, base64 = b64
        )
        again.open(null)
        assertTrue(tvLogic.urls.last().contains("token=55555"))
        again.close()
    }

    @Test
    fun samsung_denied() {
        val tv = server(SamsungTv(allow = false))
        val session = SamsungSession(
            DiscoveredTv("127.0.0.1", TvProtocol.SAMSUNG, "Samsung"), InMemoryPairingStore(), http,
            wssPort = freePort(), wsPort = tv.port, approvalTimeoutMs = 3000, base64 = b64
        )
        val error = runCatching { session.open(null) }.exceptionOrNull()
        assertTrue(error?.message.orEmpty().contains("denied"))
        assertFalse(session.isOpen)
    }

    // --------------------------------------------------------------------- LG

    private inner class LgTv : Dispatcher() {
        val buttons = CopyOnWriteArrayList<String>()
        val requests = CopyOnWriteArrayList<JSONObject>()
        var registerPayload: JSONObject? = null
        var pointerUrl = ""
        override fun dispatch(request: RecordedRequest): MockResponse {
            if (request.path == "/pointer") {
                return MockResponse().withWebSocketUpgrade(object : WebSocketListener() {
                    override fun onMessage(webSocket: WebSocket, text: String) {
                        Regex("name:(\\S+)").find(text)?.groupValues?.get(1)?.let { buttons += it }
                    }
                })
            }
            return MockResponse().withWebSocketUpgrade(object : WebSocketListener() {
                override fun onMessage(webSocket: WebSocket, text: String) {
                    val json = JSONObject(text)
                    val id = json.optString("id")
                    when (json.optString("type")) {
                        "register" -> {
                            registerPayload = json.getJSONObject("payload")
                            webSocket.send("""{"type":"response","id":"$id","payload":{"pairingType":"PROMPT","returnValue":true}}""")
                            webSocket.send("""{"type":"registered","id":"$id","payload":{"client-key":"lgkey123"}}""")
                        }
                        "request" -> {
                            requests += json
                            val payload = if (json.getString("uri").endsWith("getPointerInputSocket"))
                                """{"returnValue":true,"socketPath":"$pointerUrl"}""" else """{"returnValue":true}"""
                            webSocket.send("""{"type":"response","id":"$id","payload":$payload}""")
                        }
                    }
                }
            })
        }
    }

    @Test
    fun lg_registersWithPromptThenButtonsAndText() {
        val logic = LgTv()
        val tv = server(logic)
        logic.pointerUrl = "ws://127.0.0.1:${tv.port}/pointer"
        val store = InMemoryPairingStore()
        val prompts = ArrayList<String>()
        val session = WebOsSession(
            DiscoveredTv("127.0.0.1", TvProtocol.LG_WEBOS, "LG"), store, http,
            wsPort = tv.port, wssPort = freePort(), approvalTimeoutMs = 3000, requestTimeoutMs = 2000
        )
        session.open { prompts += it }
        assertTrue(session.isOpen)
        assertEquals("lgkey123", store.lgClientKey("127.0.0.1"))
        assertTrue(prompts.isNotEmpty())
        val manifest = logic.registerPayload!!.getJSONObject("manifest")
        assertEquals("com.lge.test", manifest.getJSONObject("signed").getString("appId"))

        listOf(RemoteCommand.HOME, RemoteCommand.MENU, RemoteCommand.BACK, RemoteCommand.OK, RemoteCommand.DIGIT_7)
            .forEach { assertTrue(session.send(it) is TransmitResult.Sent) }
        waitFor { logic.buttons.size >= 5 }
        assertEquals(listOf("HOME", "MENU", "BACK", "ENTER", "7"), logic.buttons.toList())

        assertTrue(session.send(RemoteCommand.INPUT) is TransmitResult.Sent)
        assertTrue(session.sendText("hello") is TransmitResult.Sent)
        assertTrue(session.sendText("\b") is TransmitResult.Sent)
        val uris = logic.requests.map { it.getString("uri") }
        assertTrue(uris.contains("ssap://system.launcher/launch"))
        val insert = logic.requests.first { it.getString("uri") == "ssap://com.webos.service.ime/insertText" }
        assertEquals("hello", insert.getJSONObject("payload").getString("text"))
        assertTrue(uris.contains("ssap://com.webos.service.ime/deleteCharacters"))
        session.close()

        // Next time the stored key is sent
        val again = WebOsSession(
            DiscoveredTv("127.0.0.1", TvProtocol.LG_WEBOS, "LG"), store, http,
            wsPort = tv.port, wssPort = freePort(), approvalTimeoutMs = 3000
        )
        again.open(null)
        assertEquals("lgkey123", logic.registerPayload!!.getString("client-key"))
        again.close()
    }

    // ------------------------------------------------------------------- Roku

    @Test
    fun roku_keypressesAndLiteralText() {
        val paths = CopyOnWriteArrayList<String>()
        val tv = server(object : Dispatcher() {
            override fun dispatch(request: RecordedRequest): MockResponse {
                paths += "${request.method} ${request.path}"
                return if (request.path == "/query/device-info")
                    MockResponse().setBody("<device-info><user-device-name>Living Room Roku</user-device-name></device-info>")
                else MockResponse()
            }
        })
        val session = RokuSession(DiscoveredTv("127.0.0.1", TvProtocol.ROKU, "Roku"), http, tv.port)
        assertTrue(session.send(RemoteCommand.HOME) is TransmitResult.Sent)
        assertTrue(session.send(RemoteCommand.OK) is TransmitResult.Sent)
        assertTrue(session.sendText("a b") is TransmitResult.Sent)
        assertEquals(
            listOf("POST /keypress/Home", "POST /keypress/Select", "POST /keypress/Lit_a",
                "POST /keypress/Lit_%20", "POST /keypress/Lit_b"),
            paths.toList()
        )
    }

    @Test
    fun manager_detectsRokuByPortAndReadsName() {
        val tv = server(object : Dispatcher() {
            override fun dispatch(request: RecordedRequest): MockResponse =
                MockResponse().setBody("<device-info><user-device-name>Living Room Roku</user-device-name></device-info>")
        })
        val wifi = WifiRemoteManager(
            InMemoryPairingStore(), identity = { error("unused") },
            ports = TvPorts(freePort(), freePort(), freePort(), freePort(), freePort(), freePort(), tv.port, freePort()),
            http = http
        )
        val found = wifi.detect("127.0.0.1")
        assertEquals(TvProtocol.ROKU, found?.protocol)
        assertEquals("Living Room Roku", found?.name)
        val discovered = TvDiscovery(wifi).scanHosts(listOf("127.0.0.1"), timeoutSeconds = 5)
        assertEquals(listOf("127.0.0.1"), discovered.map { it.ip })
        assertTrue(wifi.connect(found!!, null) is ConnectOutcome.Connected)
        assertTrue(wifi.send(RemoteCommand.VOL_UP) is TransmitResult.Sent)
        assertTrue(wifi.detect("127.0.0.1").let { it != null })
    }

    @Test
    fun manager_reportsNothingFound() {
        val wifi = WifiRemoteManager(
            InMemoryPairingStore(), identity = { error("unused") },
            ports = TvPorts(freePort(), freePort(), freePort(), freePort(), freePort(), freePort(), freePort(), freePort()),
            http = http
        )
        val result = wifi.connectIp("127.0.0.1", null)
        assertTrue(result is ConnectOutcome.Failed)
        assertTrue(wifi.connectIp("not-an-ip", null) is ConnectOutcome.Failed)
    }

    @Test
    fun keyTablesCoverEveryCommand() {
        RemoteCommand.entries.forEach {
            assertTrue(SamsungSession.keyFor(it).startsWith("KEY_"))
            assertTrue(WebOsSession.buttonFor(it).isNotBlank())
            assertTrue(RokuSession.keyFor(it).isNotBlank())
        }
    }
}
