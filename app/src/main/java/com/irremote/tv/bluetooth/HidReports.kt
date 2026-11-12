package com.irremote.tv.bluetooth

import com.irremote.tv.ir.RemoteCommand

/**
 * HID descriptor + report builders for a combined keyboard / media‑keys / mouse device.
 * Android TV, Google TV, Fire TV, LG, Samsung and most smart TVs accept these as a BT keyboard+mouse.
 */
object HidReports {
    const val ID_KEYBOARD = 1
    const val ID_CONSUMER = 2
    const val ID_MOUSE = 3

    val DESCRIPTOR: ByteArray = bytes(
        // Keyboard
        0x05, 0x01, 0x09, 0x06, 0xA1, 0x01, 0x85, ID_KEYBOARD,
        0x05, 0x07, 0x19, 0xE0, 0x29, 0xE7, 0x15, 0x00, 0x25, 0x01, 0x75, 0x01, 0x95, 0x08, 0x81, 0x02,
        0x95, 0x01, 0x75, 0x08, 0x81, 0x01,
        0x95, 0x06, 0x75, 0x08, 0x15, 0x00, 0x25, 0x65, 0x05, 0x07, 0x19, 0x00, 0x29, 0x65, 0x81, 0x00,
        0xC0,
        // Consumer control (media / TV keys)
        0x05, 0x0C, 0x09, 0x01, 0xA1, 0x01, 0x85, ID_CONSUMER,
        0x15, 0x00, 0x26, 0xFF, 0x03, 0x19, 0x00, 0x2A, 0xFF, 0x03, 0x75, 0x10, 0x95, 0x01, 0x81, 0x00,
        0xC0,
        // Mouse
        0x05, 0x01, 0x09, 0x02, 0xA1, 0x01, 0x85, ID_MOUSE, 0x09, 0x01, 0xA1, 0x00,
        0x05, 0x09, 0x19, 0x01, 0x29, 0x03, 0x15, 0x00, 0x25, 0x01, 0x95, 0x03, 0x75, 0x01, 0x81, 0x02,
        0x95, 0x01, 0x75, 0x05, 0x81, 0x01,
        0x05, 0x01, 0x09, 0x30, 0x09, 0x31, 0x09, 0x38, 0x15, 0x81, 0x25, 0x7F, 0x75, 0x08, 0x95, 0x03, 0x81, 0x06,
        0xC0, 0xC0
    )

    const val MOD_SHIFT = 0x02

    /** A HID key: either a keyboard usage (with modifiers) or a consumer usage. */
    sealed class Key {
        data class Keyboard(val usage: Int, val modifiers: Int = 0) : Key()
        data class Consumer(val usage: Int) : Key()
    }

    fun keyFor(command: RemoteCommand): Key? = when (command) {
        RemoteCommand.POWER -> Key.Consumer(0x30)
        RemoteCommand.MUTE -> Key.Consumer(0xE2)
        RemoteCommand.VOL_UP -> Key.Consumer(0xE9)
        RemoteCommand.VOL_DOWN -> Key.Consumer(0xEA)
        RemoteCommand.CH_UP -> Key.Consumer(0x9C)
        RemoteCommand.CH_DOWN -> Key.Consumer(0x9D)
        RemoteCommand.UP -> Key.Keyboard(0x52)
        RemoteCommand.DOWN -> Key.Keyboard(0x51)
        RemoteCommand.LEFT -> Key.Keyboard(0x50)
        RemoteCommand.RIGHT -> Key.Keyboard(0x4F)
        RemoteCommand.OK -> Key.Keyboard(0x28)
        RemoteCommand.HOME -> Key.Consumer(0x223)
        RemoteCommand.BACK -> Key.Consumer(0x224)
        RemoteCommand.MENU -> Key.Consumer(0x40)
        // F3 reaches the TV as KEYCODE_F3, which opens the Google TV Inputs panel
        RemoteCommand.INPUT -> Key.Keyboard(0x3C)
        RemoteCommand.DIGIT_0 -> Key.Keyboard(0x27)
        RemoteCommand.DIGIT_1 -> Key.Keyboard(0x1E)
        RemoteCommand.DIGIT_2 -> Key.Keyboard(0x1F)
        RemoteCommand.DIGIT_3 -> Key.Keyboard(0x20)
        RemoteCommand.DIGIT_4 -> Key.Keyboard(0x21)
        RemoteCommand.DIGIT_5 -> Key.Keyboard(0x22)
        RemoteCommand.DIGIT_6 -> Key.Keyboard(0x23)
        RemoteCommand.DIGIT_7 -> Key.Keyboard(0x24)
        RemoteCommand.DIGIT_8 -> Key.Keyboard(0x25)
        RemoteCommand.DIGIT_9 -> Key.Keyboard(0x26)
    }

    private const val SHIFTED_DIGITS = ")!@#$%^&*("

    fun keyForChar(ch: Char): Key.Keyboard? = when (ch) {
        in 'a'..'z' -> Key.Keyboard(0x04 + (ch - 'a'))
        in 'A'..'Z' -> Key.Keyboard(0x04 + (ch - 'A'), MOD_SHIFT)
        '0' -> Key.Keyboard(0x27)
        in '1'..'9' -> Key.Keyboard(0x1E + (ch - '1'))
        in SHIFTED_DIGITS -> {
            val digit = SHIFTED_DIGITS.indexOf(ch)
            Key.Keyboard(if (digit == 0) 0x27 else 0x1E + digit - 1, MOD_SHIFT)
        }
        '\n' -> Key.Keyboard(0x28)
        '\b' -> Key.Keyboard(0x2A)
        '\t' -> Key.Keyboard(0x2B)
        ' ' -> Key.Keyboard(0x2C)
        '-' -> Key.Keyboard(0x2D)
        '_' -> Key.Keyboard(0x2D, MOD_SHIFT)
        '=' -> Key.Keyboard(0x2E)
        '+' -> Key.Keyboard(0x2E, MOD_SHIFT)
        '[' -> Key.Keyboard(0x2F)
        ']' -> Key.Keyboard(0x30)
        '\\' -> Key.Keyboard(0x31)
        ';' -> Key.Keyboard(0x33)
        ':' -> Key.Keyboard(0x33, MOD_SHIFT)
        '\'' -> Key.Keyboard(0x34)
        '"' -> Key.Keyboard(0x34, MOD_SHIFT)
        ',' -> Key.Keyboard(0x36)
        '.' -> Key.Keyboard(0x37)
        '/' -> Key.Keyboard(0x38)
        '?' -> Key.Keyboard(0x38, MOD_SHIFT)
        else -> null
    }

    fun keyboard(usage: Int, modifiers: Int = 0): ByteArray =
        byteArrayOf(modifiers.toByte(), 0, usage.toByte(), 0, 0, 0, 0, 0)

    val KEYBOARD_RELEASE = ByteArray(8)

    fun consumer(usage: Int): ByteArray = byteArrayOf((usage and 0xFF).toByte(), (usage shr 8 and 0xFF).toByte())

    val CONSUMER_RELEASE = ByteArray(2)

    fun mouse(buttons: Int, dx: Int, dy: Int, wheel: Int = 0): ByteArray = byteArrayOf(
        (buttons and 0x07).toByte(),
        dx.coerceIn(-127, 127).toByte(),
        dy.coerceIn(-127, 127).toByte(),
        wheel.coerceIn(-127, 127).toByte()
    )

    private fun bytes(vararg values: Int) = ByteArray(values.size) { values[it].toByte() }
}
