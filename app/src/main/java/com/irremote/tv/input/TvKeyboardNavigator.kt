package com.irremote.tv.input

import com.irremote.tv.ir.RemoteCommand

/**
 * Models a typical smart-TV on-screen QWERTY keyboard and converts character
 * requests into IR navigation commands (arrows + OK / Back).
 *
 * Call [resetCursor] when the TV keyboard is opened so the assumed focus starts
 * on the first key. Digits can also be sent as direct IR digit codes via
 * [digitCommand].
 */
class TvKeyboardNavigator(
    private val layout: List<String> = DEFAULT_LAYOUT
) {
    var row: Int = 0
        private set
    var col: Int = 0
        private set

    fun resetCursor(startRow: Int = 0, startCol: Int = 0) {
        row = startRow.coerceIn(0, layout.lastIndex)
        col = startCol.coerceIn(0, layout[row].lastIndex)
    }

    fun currentChar(): Char = layout[row][col]

    /**
     * Returns IR commands to move focus to [target] and confirm with OK.
     * Space uses the dedicated space key; Backspace maps to Back.
     */
    fun typeCharacter(target: Char): List<RemoteCommand> {
        when (target) {
            '\b' -> return listOf(RemoteCommand.BACK)
            '\n' -> return moveTo('↵') + RemoteCommand.OK
            ' ' -> return moveTo(' ') + RemoteCommand.OK
        }
        val normalized = target.lowercaseChar()
        if (normalized !in KEY_SET) return emptyList()
        return moveTo(normalized) + RemoteCommand.OK
    }

    fun moveTo(target: Char): List<RemoteCommand> {
        val pos = positionOf(target) ?: return emptyList()
        return pathTo(pos.first, pos.second)
    }

    fun pathTo(targetRow: Int, targetCol: Int): List<RemoteCommand> {
        val commands = ArrayList<RemoteCommand>()
        while (row < targetRow) {
            commands += RemoteCommand.DOWN
            row++
        }
        while (row > targetRow) {
            commands += RemoteCommand.UP
            row--
        }
        while (col < targetCol) {
            commands += RemoteCommand.RIGHT
            col++
        }
        while (col > targetCol) {
            commands += RemoteCommand.LEFT
            col--
        }
        return commands
    }

    fun digitCommand(digit: Int): RemoteCommand = RemoteCommand.digit(digit)

    private fun positionOf(target: Char): Pair<Int, Int>? {
        layout.forEachIndexed { r, line ->
            val c = line.indexOf(target)
            if (c >= 0) return r to c
        }
        return null
    }

    companion object {
        val DEFAULT_LAYOUT = listOf(
            "1234567890",
            "qwertyuiop",
            "asdfghjkl↵",
            "zxcvbnm ."
        )

        private val KEY_SET: Set<Char> =
            DEFAULT_LAYOUT.flatMap { it.toList() }.toSet()
    }
}
