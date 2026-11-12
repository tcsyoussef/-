package com.irremote.tv.net

import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.net.androidtv.ClientIdentity
import org.junit.Assert.assertArrayEquals
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [34])
class VoiceSearchTest {
    @Test
    fun androidTvStreamsVoiceAfterSearch() {
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
            assertTrue(wifi.supportsVoice)

            assertTrue(wifi.startVoice() is TransmitResult.Sent)
            waitFor { tv.voiceSessions.isNotEmpty() }
            assertEquals(listOf(7), tv.voiceSessions.toList())

            val pcm = ByteArray(32) { it.toByte() }
            assertTrue(wifi.sendVoicePcm(pcm) is TransmitResult.Sent)
            waitFor { tv.voicePayloads.isNotEmpty() }
            assertArrayEquals(pcm, tv.voicePayloads.first())

            assertTrue(wifi.endVoice() is TransmitResult.Sent)
            waitFor { tv.voiceEnds.isNotEmpty() }
            assertEquals(listOf(7), tv.voiceEnds.toList())
            assertTrue(tv.keyCodes.contains(84))
        }
    }
}
