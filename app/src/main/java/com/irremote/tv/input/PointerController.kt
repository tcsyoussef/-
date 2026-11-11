package com.irremote.tv.input

import com.irremote.tv.ir.RemoteCommand
import kotlin.math.abs

/**
 * Converts continuous pointer / touchpad motion into discrete IR D-pad steps.
 * Click maps to OK. Functional for navigating TV UIs over infrared.
 */
class PointerController(
    private val stepPixels: Float = 48f,
    private val minIntervalMs: Long = 90L
) {
    private var accumX = 0f
    private var accumY = 0f
    private var lastEmitAt = 0L

    fun reset() {
        accumX = 0f
        accumY = 0f
        lastEmitAt = 0L
    }

    /**
     * Feed a motion delta. Returns zero or more IR direction commands.
     */
    fun onMove(dx: Float, dy: Float, nowMs: Long = System.currentTimeMillis()): List<RemoteCommand> {
        accumX += dx
        accumY += dy
        if (nowMs - lastEmitAt < minIntervalMs) {
            return emptyList()
        }

        val commands = ArrayList<RemoteCommand>(2)
        when {
            abs(accumX) >= abs(accumY) && abs(accumX) >= stepPixels -> {
                commands += if (accumX > 0) RemoteCommand.RIGHT else RemoteCommand.LEFT
                accumX = 0f
                accumY *= 0.35f
                lastEmitAt = nowMs
            }
            abs(accumY) >= stepPixels -> {
                commands += if (accumY > 0) RemoteCommand.DOWN else RemoteCommand.UP
                accumY = 0f
                accumX *= 0.35f
                lastEmitAt = nowMs
            }
        }
        return commands
    }

    fun onClick(): RemoteCommand = RemoteCommand.OK

    fun onScroll(vertical: Float): RemoteCommand? = when {
        vertical > 0.4f -> RemoteCommand.CH_DOWN
        vertical < -0.4f -> RemoteCommand.CH_UP
        else -> null
    }
}
