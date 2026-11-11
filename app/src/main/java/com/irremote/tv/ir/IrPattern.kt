package com.irremote.tv.ir

/**
 * Carrier frequency (Hz) and pulse pattern for [android.hardware.ConsumerIrManager.transmit].
 * Pattern values are durations in microseconds, alternating mark/space starting with mark.
 */
data class IrPattern(
    val frequencyHz: Int,
    val patternMicros: IntArray
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other !is IrPattern) return false
        return frequencyHz == other.frequencyHz && patternMicros.contentEquals(other.patternMicros)
    }

    override fun hashCode(): Int {
        var result = frequencyHz
        result = 31 * result + patternMicros.contentHashCode()
        return result
    }

    fun totalDurationMicros(): Long = patternMicros.sumOf { it.toLong() }
}
