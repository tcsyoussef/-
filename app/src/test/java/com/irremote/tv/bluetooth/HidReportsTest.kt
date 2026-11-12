package com.irremote.tv.bluetooth

import com.irremote.tv.ir.RemoteCommand
import org.junit.Assert.assertArrayEquals
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test

class HidReportsTest {
    @Test
    fun descriptorCollectionsAreBalanced() {
        val d = HidReports.DESCRIPTOR.map { it.toInt() and 0xFF }
        var depth = 0
        var i = 0
        while (i < d.size) {
            val prefix = d[i]
            val size = when (prefix and 0x03) { 3 -> 4; else -> prefix and 0x03 }
            if (prefix and 0xFC == 0xA0) depth++
            if (prefix == 0xC0) depth--
            i += 1 + size
        }
        assertEquals(d.size, i)
        assertEquals(0, depth)
    }

    @Test
    fun remoteKeysMapToHidUsages() {
        assertEquals(HidReports.Key.Consumer(0x223), HidReports.keyFor(RemoteCommand.HOME))
        assertEquals(HidReports.Key.Consumer(0x224), HidReports.keyFor(RemoteCommand.BACK))
        assertEquals(HidReports.Key.Keyboard(0x52), HidReports.keyFor(RemoteCommand.UP))
        assertEquals(HidReports.Key.Keyboard(0x27), HidReports.keyFor(RemoteCommand.DIGIT_0))
        assertEquals(HidReports.Key.Keyboard(0x3C), HidReports.keyFor(RemoteCommand.INPUT))
    }

    @Test
    fun charactersAndReports() {
        assertEquals(HidReports.Key.Keyboard(0x04), HidReports.keyForChar('a'))
        assertEquals(HidReports.Key.Keyboard(0x1D, HidReports.MOD_SHIFT), HidReports.keyForChar('Z'))
        assertEquals(HidReports.Key.Keyboard(0x1F, HidReports.MOD_SHIFT), HidReports.keyForChar('@'))
        assertEquals(HidReports.Key.Keyboard(0x27, HidReports.MOD_SHIFT), HidReports.keyForChar(')'))
        assertEquals(HidReports.Key.Keyboard(0x2A), HidReports.keyForChar('\b'))
        assertArrayEquals(byteArrayOf(2, 0, 4, 0, 0, 0, 0, 0), HidReports.keyboard(4, 2))
        assertArrayEquals(byteArrayOf(0x23, 0x02), HidReports.consumer(0x223))
        assertArrayEquals(byteArrayOf(1, 127, -127, 0), HidReports.mouse(1, 500, -500))
    }
}
