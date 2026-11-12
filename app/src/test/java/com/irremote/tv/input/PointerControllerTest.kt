package com.irremote.tv.input

import com.irremote.tv.ir.RemoteCommand
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class PointerControllerTest {

    @Test
    fun moveRight_emitsRightWhenPastStep() {
        val pointer = PointerController(stepPixels = 40f, minIntervalMs = 0L)
        assertTrue(pointer.onMove(20f, 0f, nowMs = 1).isEmpty())
        assertEquals(listOf(RemoteCommand.RIGHT), pointer.onMove(25f, 0f, nowMs = 2))
    }

    @Test
    fun moveUp_emitsUp() {
        val pointer = PointerController(stepPixels = 40f, minIntervalMs = 0L)
        assertEquals(listOf(RemoteCommand.UP), pointer.onMove(0f, -50f, nowMs = 1))
    }

    @Test
    fun click_isOk() {
        assertEquals(RemoteCommand.OK, PointerController().onClick())
    }

    @Test
    fun scroll_mapsToChannel() {
        val pointer = PointerController()
        assertEquals(RemoteCommand.CH_UP, pointer.onScroll(-1f))
        assertEquals(RemoteCommand.CH_DOWN, pointer.onScroll(1f))
    }
}
