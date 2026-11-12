package com.irremote.tv.net

import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.net.androidtv.ClientIdentity
import com.irremote.tv.net.androidtv.ProtoReader
import com.irremote.tv.net.androidtv.ProtoWriter
import org.junit.Assert.assertArrayEquals
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertTrue
import org.junit.Test
import java.io.ByteArrayInputStream
import java.io.File
import java.net.ServerSocket

fun freePort(): Int = ServerSocket(0).use { it.localPort }

class AndroidTvProtocolTest {

    private val identity by lazy { ClientIdentity.generate() }

    @Test
    fun protoRoundTrip() {
        val bytes = ProtoWriter()
            .varint(1, 300)
            .string(2, "héllo")
            .message(10, ProtoWriter().varint(1, 3).bytes(2, byteArrayOf(1, 2, 3)))
            .toByteArray()
        val framed = ProtoWriter.frame(bytes)
        val msg = ProtoReader.parse(ProtoReader.readFrame(ByteArrayInputStream(framed))!!)
        assertEquals(300L, msg.varint(1))
        assertEquals("héllo", msg.string(2))
        assertEquals(3L, msg.message(10)?.varint(1))
        assertArrayEquals(byteArrayOf(1, 2, 3), msg.message(10)?.bytes(2))
    }

    @Test
    fun clientCertificateIsValidAndPersists() {
        identity.certificate.checkValidity()
        identity.certificate.verify(identity.publicKey)
        assertEquals("SHA256withRSA", identity.certificate.sigAlgName)
        val file = File.createTempFile("atv", ".p12").also { it.delete() }
        val first = ClientIdentity.loadOrCreate(file)
        val again = ClientIdentity.loadOrCreate(file)
        assertEquals(first.publicKey.modulus, again.publicKey.modulus)
        file.delete()
    }

    private fun manager(tv: MockAndroidTv, store: PairingStore = InMemoryPairingStore()) = WifiRemoteManager(
        store = store,
        identity = { identity },
        ports = TvPorts(
            androidTvRemote = tv.remotePort,
            androidTvPairing = tv.pairingPort,
            samsungWs = freePort(), samsungWss = freePort(),
            lgWs = freePort(), lgWss = freePort(),
            roku = freePort(), haierDiscover = freePort()
        )
    )

    @Test
    fun pairsWithCodeThenSendsKeysAndText() {
        MockAndroidTv().use { tv ->
            val store = InMemoryPairingStore()
            val wifi = manager(tv, store)

            val first = wifi.connectIp("127.0.0.1", null)
            assertTrue("expected PIN prompt, got $first", first is ConnectOutcome.NeedsPin)
            val code = tv.shownCode!!

            // Code whose first byte doesn't match is rejected locally and re-prompts
            val badPrefix = "%02X".format((code.substring(0, 2).toInt(16) + 1) and 0xFF) + code.substring(2)
            val retry = (first as ConnectOutcome.NeedsPin).submit(badPrefix)
            assertTrue("expected re-prompt, got $retry", retry is ConnectOutcome.NeedsPin)
            assertNotNull((retry as ConnectOutcome.NeedsPin).error)

            val done = retry.submit(code.lowercase())
            assertTrue("expected connected, got $done", done is ConnectOutcome.Connected)
            assertTrue(wifi.isReady)
            assertEquals(TvProtocol.ANDROID_TV, store.lastTv()?.protocol)

            for (command in listOf(RemoteCommand.HOME, RemoteCommand.INPUT, RemoteCommand.MENU, RemoteCommand.OK)) {
                assertTrue(wifi.send(command) is TransmitResult.Sent)
            }
            assertTrue(wifi.sendText("hi") is TransmitResult.Sent)
            waitFor { tv.keyCodes.size >= 6 }
            assertEquals(listOf(3, 178, 82, 23, 36, 37), tv.keyCodes.toList())

            // Reconnect with saved cert: no pairing needed
            wifi.disconnect()
            val again = wifi.connect(store.lastTv()!!, null)
            assertTrue("expected direct reconnect, got $again", again is ConnectOutcome.Connected)
        }
    }

    @Test
    fun typesWithImeBatchEditWhenTextFieldFocused() {
        MockAndroidTv().use { tv ->
            tv.sendImeFocus = true
            val wifi = manager(tv)
            val pin = wifi.connectIp("127.0.0.1", null) as ConnectOutcome.NeedsPin
            assertTrue(pin.submit(tv.shownCode!!) is ConnectOutcome.Connected)
            Thread.sleep(300)
            assertTrue(wifi.sendText("netflix") is TransmitResult.Sent)
            waitFor { tv.batchTexts.isNotEmpty() }
            assertEquals("netflix", tv.batchTexts.first())
        }
    }

    @Test
    fun wrongCodeRejectedByTv() {
        MockAndroidTv().use { tv ->
            val wifi = manager(tv)
            val pin = wifi.connectIp("127.0.0.1", null) as ConnectOutcome.NeedsPin
            val code = tv.shownCode!!
            // Same first byte, different suffix: passes local check, TV answers 402
            val wrongSuffix = code.substring(0, 2) + if (code.substring(2) == "0000") "0001" else "0000"
            val result = pin.submit(wrongSuffix)
            assertTrue("got $result", result is ConnectOutcome.Failed || result is ConnectOutcome.NeedsPin)
            assertTrue(!wifi.isReady)
        }
    }
}

fun waitFor(timeoutMs: Long = 3000, condition: () -> Boolean) {
    val end = System.currentTimeMillis() + timeoutMs
    while (!condition() && System.currentTimeMillis() < end) Thread.sleep(20)
}
