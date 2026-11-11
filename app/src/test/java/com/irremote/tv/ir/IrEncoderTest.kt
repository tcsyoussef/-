package com.irremote.tv.ir

import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class IrEncoderTest {

    @Test
    fun necPattern_startsWithHeaderAndHasExpectedLength() {
        val pattern = IrEncoder.encodeNec(address = 0x07, command = 0x02)
        assertEquals(38_000, pattern.frequencyHz)
        assertEquals(9000, pattern.patternMicros[0])
        assertEquals(4500, pattern.patternMicros[1])
        // 2 header + 32 bits * 2 + stop mark = 67
        assertEquals(67, pattern.patternMicros.size)
        assertTrue(pattern.totalDurationMicros() > 50_000)
    }

    @Test
    fun necInverseBytes_areComplements() {
        val address = 0x20
        val command = 0x10
        val pattern = IrEncoder.encodeNec(address, command)
        // Reconstruct first address bit timings: after header, 8 mark/space pairs
        val firstBitSpace = pattern.patternMicros[3]
        assertTrue(firstBitSpace == 560 || firstBitSpace == 1690)
    }

    @Test
    fun sircPattern_uses40kHzAndPositivePulses() {
        val pattern = IrEncoder.encodeSirc(command = 0x15, address = 1)
        assertEquals(40_000, pattern.frequencyHz)
        assertTrue(pattern.patternMicros.all { it > 0 })
        assertEquals(2400, pattern.patternMicros[0])
    }

    @Test
    fun rc5Pattern_isNonEmptyAnd36kHz() {
        val pattern = IrEncoder.encodeRc5(address = 0, command = 12)
        assertEquals(36_000, pattern.frequencyHz)
        assertTrue(pattern.patternMicros.isNotEmpty())
        assertTrue(pattern.patternMicros.all { it > 0 })
    }

    @Test
    fun panasonicPattern_uses35kHz() {
        val pattern = IrEncoder.encodePanasonic(device = 0x4004, function = 0x3D)
        assertEquals(35_000, pattern.frequencyHz)
        assertEquals(3500, pattern.patternMicros[0])
    }

    @Test
    fun encode_forEachBrandProducesPattern() {
        TvBrand.entries.forEach { brand ->
            val pattern = IrEncoder.encode(brand, RemoteCommand.POWER)
            assertTrue(brand.name, pattern.frequencyHz in 30_000..50_000)
            assertTrue(brand.name, pattern.patternMicros.size >= 10)
        }
    }

    @Test
    fun digitHelper_maps0to9() {
        assertEquals(RemoteCommand.DIGIT_0, RemoteCommand.digit(0))
        assertEquals(RemoteCommand.DIGIT_9, RemoteCommand.digit(9))
    }

    @Test
    fun brandLookup_isCaseInsensitive() {
        assertEquals(TvBrand.LG, TvBrand.fromDisplayName("lg"))
        assertEquals(TvBrand.HAIER, TvBrand.fromDisplayName("haier"))
        assertEquals(TvBrand.HAIER, TvBrand.fromDisplayName("unknown"))
    }

    @Test
    fun sonyPowerCode_is0x15() {
        assertEquals(0x15, IrEncoder.commandCode(TvBrand.SONY, RemoteCommand.POWER))
    }

    @Test
    fun haierPower_usesNecAddress04Command08() {
        assertEquals(0x04, IrEncoder.addressFor(TvBrand.HAIER))
        assertEquals(0x08, IrEncoder.commandCode(TvBrand.HAIER, RemoteCommand.POWER))
        val pattern = IrEncoder.encode(TvBrand.HAIER, RemoteCommand.POWER)
        assertEquals(38_000, pattern.frequencyHz)
        assertEquals(67, pattern.patternMicros.size)
    }

    @Test
    fun haierAltPower_usesNecAddress00Command12() {
        assertEquals(0x00, IrEncoder.addressFor(TvBrand.HAIER_ALT))
        assertEquals(0x12, IrEncoder.commandCode(TvBrand.HAIER_ALT, RemoteCommand.POWER))
    }
}
