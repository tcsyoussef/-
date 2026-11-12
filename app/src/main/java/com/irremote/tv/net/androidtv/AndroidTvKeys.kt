package com.irremote.tv.net.androidtv

import com.irremote.tv.ir.RemoteCommand

/** Android KeyEvent codes sent through the Remote v2 protocol. */
object AndroidTvKeys {
    const val KEYCODE_ENTER = 66
    const val KEYCODE_DEL = 67
    const val KEYCODE_TV_INPUT = 178

    /** KEYCODE_F3: opens the Google TV launcher's Inputs panel; most TVs ignore KEYCODE_TV_INPUT from the remote service. */
    const val KEYCODE_INPUTS_PANEL = 133

    fun keyCode(command: RemoteCommand): Int = when (command) {
        RemoteCommand.POWER -> 26
        RemoteCommand.MUTE -> 164
        RemoteCommand.VOL_UP -> 24
        RemoteCommand.VOL_DOWN -> 25
        RemoteCommand.CH_UP -> 166
        RemoteCommand.CH_DOWN -> 167
        RemoteCommand.UP -> 19
        RemoteCommand.DOWN -> 20
        RemoteCommand.LEFT -> 21
        RemoteCommand.RIGHT -> 22
        RemoteCommand.OK -> 23
        RemoteCommand.HOME -> 3
        RemoteCommand.BACK -> 4
        RemoteCommand.MENU -> 82
        RemoteCommand.INPUT -> KEYCODE_INPUTS_PANEL
        RemoteCommand.DIGIT_0 -> 7
        RemoteCommand.DIGIT_1 -> 8
        RemoteCommand.DIGIT_2 -> 9
        RemoteCommand.DIGIT_3 -> 10
        RemoteCommand.DIGIT_4 -> 11
        RemoteCommand.DIGIT_5 -> 12
        RemoteCommand.DIGIT_6 -> 13
        RemoteCommand.DIGIT_7 -> 14
        RemoteCommand.DIGIT_8 -> 15
        RemoteCommand.DIGIT_9 -> 16
    }

    fun keyCodeForChar(ch: Char): Int? {
        val c = ch.lowercaseChar()
        return when (c) {
            in 'a'..'z' -> 29 + (c - 'a')
            in '0'..'9' -> 7 + (c - '0')
            ' ' -> 62
            '.' -> 56
            ',' -> 55
            '@' -> 77
            '-' -> 69
            '/' -> 76
            '\n' -> KEYCODE_ENTER
            '\b' -> KEYCODE_DEL
            else -> null
        }
    }
}
