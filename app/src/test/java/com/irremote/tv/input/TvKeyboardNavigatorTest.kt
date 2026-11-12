package com.irremote.tv.input

import com.irremote.tv.ir.RemoteCommand
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class TvKeyboardNavigatorTest {

    @Test
    fun typeA_fromStart_movesRightAndConfirms() {
        val nav = TvKeyboardNavigator()
        nav.resetCursor()
        // start at '1' (0,0); 'a' is row 2 col 0
        val commands = nav.typeCharacter('a')
        assertTrue(commands.contains(RemoteCommand.DOWN))
        assertEquals(RemoteCommand.OK, commands.last())
        assertEquals('a', nav.currentChar())
    }

    @Test
    fun typeSameKeyTwice_secondNeedsOnlyOk() {
        val nav = TvKeyboardNavigator()
        nav.resetCursor()
        nav.typeCharacter('q')
        val second = nav.typeCharacter('q')
        assertEquals(listOf(RemoteCommand.OK), second)
    }

    @Test
    fun backspace_mapsToBack() {
        val nav = TvKeyboardNavigator()
        assertEquals(listOf(RemoteCommand.BACK), nav.typeCharacter('\b'))
    }

    @Test
    fun pathTo_isShortestAxisAligned() {
        val nav = TvKeyboardNavigator()
        nav.resetCursor(0, 0)
        val path = nav.pathTo(1, 3) // 'r'
        assertEquals(
            listOf(
                RemoteCommand.DOWN,
                RemoteCommand.RIGHT,
                RemoteCommand.RIGHT,
                RemoteCommand.RIGHT
            ),
            path
        )
    }
}
