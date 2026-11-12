package com.irremote.tv.wifi

import com.irremote.tv.ir.RemoteCommand
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class HaierWifiKeyCodesTest {

    @Test
    fun powerMuteVolumeChannel_matchDocumentedCodes() {
        assertEquals(1012, HaierWifiKeyCodes.codeFor(RemoteCommand.POWER))
        assertEquals(1013, HaierWifiKeyCodes.codeFor(RemoteCommand.MUTE))
        assertEquals(1016, HaierWifiKeyCodes.codeFor(RemoteCommand.VOL_UP))
        assertEquals(1017, HaierWifiKeyCodes.codeFor(RemoteCommand.VOL_DOWN))
        assertEquals(1032, HaierWifiKeyCodes.codeFor(RemoteCommand.CH_UP))
        assertEquals(1033, HaierWifiKeyCodes.codeFor(RemoteCommand.CH_DOWN))
    }

    @Test
    fun dpad_matchDocumentedCodes() {
        assertEquals(1020, HaierWifiKeyCodes.codeFor(RemoteCommand.UP))
        assertEquals(1019, HaierWifiKeyCodes.codeFor(RemoteCommand.DOWN))
        assertEquals(1021, HaierWifiKeyCodes.codeFor(RemoteCommand.LEFT))
        assertEquals(1022, HaierWifiKeyCodes.codeFor(RemoteCommand.RIGHT))
        assertEquals(1053, HaierWifiKeyCodes.codeFor(RemoteCommand.OK))
    }

    @Test
    fun homeMenuInput_matchVestelHaierCodes() {
        assertEquals(1048, HaierWifiKeyCodes.codeFor(RemoteCommand.HOME))
        assertEquals(1066, HaierWifiKeyCodes.codeFor(RemoteCommand.MENU))
        assertEquals(1056, HaierWifiKeyCodes.codeFor(RemoteCommand.INPUT))
        assertEquals(1010, HaierWifiKeyCodes.codeFor(RemoteCommand.BACK))
    }

    @Test
    fun digits_use1000Base() {
        assertEquals(1000, HaierWifiKeyCodes.codeFor(RemoteCommand.DIGIT_0))
        assertEquals(1005, HaierWifiKeyCodes.codeFor(RemoteCommand.DIGIT_5))
        assertEquals(1009, HaierWifiKeyCodes.codeFor(RemoteCommand.DIGIT_9))
    }

    @Test
    fun requestBody_embedsKeyCode() {
        val body = HaierWifiKeyCodes.requestBody(1012)
        assertTrue(body.contains("code='1012'"))
        assertTrue(body.contains("<remote>"))
        assertTrue(body.startsWith("<?xml"))
    }

    @Test
    fun requestBodies_includePrimaryVestelFormat() {
        val bodies = HaierWifiKeyCodes.requestBodies(1048)
        assertEquals("<?xml version='1.0' ?><remote><key code='1048'/></remote>", bodies.first())
        assertTrue(bodies.size >= 2)
    }
}
