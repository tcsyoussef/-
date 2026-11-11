package com.irremote.tv.ir

/**
 * Encodes consumer IR protocols into pulse patterns for [android.hardware.ConsumerIrManager].
 *
 * Haier codes are taken from public NEC captures (Flipper IRDB Haier L42C1180 and common
 * alternate address 0x00 sets). Other brands use widely documented defaults; exact codes
 * can still vary by TV model/region.
 */
object IrEncoder {

    fun encode(brand: TvBrand, command: RemoteCommand): IrPattern {
        val code = commandCode(brand, command)
        return when (brand.protocol) {
            IrProtocol.NEC -> encodeNec(addressFor(brand), code)
            IrProtocol.SIRC -> encodeSirc(code, address = 1)
            IrProtocol.RC5 -> encodeRc5(address = 0, command = code)
            IrProtocol.PANASONIC -> encodePanasonic(device = 0x4004, function = code)
        }
    }

    fun addressFor(brand: TvBrand): Int = when (brand) {
        // Flipper IRDB: Haier L42C1180 uses NEC address 0x04
        TvBrand.HAIER -> 0x04
        // Alternate Haier remotes often use address 0x00
        TvBrand.HAIER_ALT -> 0x00
        TvBrand.SAMSUNG -> 0x07
        TvBrand.LG -> 0x20
        TvBrand.TCL -> 0x00
        TvBrand.HISENSE -> 0x00
        TvBrand.SHARP -> 0x01
        TvBrand.PHILIPS -> 0x00
        TvBrand.SONY -> 0x01
        TvBrand.PANASONIC -> 0x4004
    }

    fun commandCode(brand: TvBrand, command: RemoteCommand): Int {
        if (brand == TvBrand.HAIER) {
            // NEC address 0x04 — Flipper IRDB Haier L42C1180
            return when (command) {
                RemoteCommand.POWER -> 0x08
                RemoteCommand.MUTE -> 0x09
                RemoteCommand.VOL_UP -> 0x02
                RemoteCommand.VOL_DOWN -> 0x03
                RemoteCommand.CH_UP -> 0x00
                RemoteCommand.CH_DOWN -> 0x01
                RemoteCommand.UP -> 0x40
                RemoteCommand.DOWN -> 0x41
                RemoteCommand.LEFT -> 0x07
                RemoteCommand.RIGHT -> 0x06
                RemoteCommand.OK -> 0x44
                RemoteCommand.HOME -> 0x79
                RemoteCommand.BACK -> 0x5B
                RemoteCommand.MENU -> 0x43
                RemoteCommand.INPUT -> 0x0B
                RemoteCommand.DIGIT_0 -> 0x10
                RemoteCommand.DIGIT_1 -> 0x11
                RemoteCommand.DIGIT_2 -> 0x12
                RemoteCommand.DIGIT_3 -> 0x13
                RemoteCommand.DIGIT_4 -> 0x14
                RemoteCommand.DIGIT_5 -> 0x15
                RemoteCommand.DIGIT_6 -> 0x16
                RemoteCommand.DIGIT_7 -> 0x17
                RemoteCommand.DIGIT_8 -> 0x18
                RemoteCommand.DIGIT_9 -> 0x19
            }
        }

        if (brand == TvBrand.HAIER_ALT) {
            // Common alternate Haier NEC address 0x00 set
            return when (command) {
                RemoteCommand.POWER -> 0x12
                RemoteCommand.MUTE -> 0x0D
                RemoteCommand.VOL_UP -> 0x1A
                RemoteCommand.VOL_DOWN -> 0x1B
                RemoteCommand.CH_UP -> 0x1E
                RemoteCommand.CH_DOWN -> 0x1F
                RemoteCommand.UP -> 0x16
                RemoteCommand.DOWN -> 0x17
                RemoteCommand.LEFT -> 0x19
                RemoteCommand.RIGHT -> 0x18
                RemoteCommand.OK -> 0x15
                RemoteCommand.HOME -> 0x5C
                RemoteCommand.BACK -> 0x5B
                RemoteCommand.MENU -> 0x14
                RemoteCommand.INPUT -> 0x13
                RemoteCommand.DIGIT_0 -> 0x00
                RemoteCommand.DIGIT_1 -> 0x01
                RemoteCommand.DIGIT_2 -> 0x02
                RemoteCommand.DIGIT_3 -> 0x03
                RemoteCommand.DIGIT_4 -> 0x04
                RemoteCommand.DIGIT_5 -> 0x05
                RemoteCommand.DIGIT_6 -> 0x06
                RemoteCommand.DIGIT_7 -> 0x07
                RemoteCommand.DIGIT_8 -> 0x08
                RemoteCommand.DIGIT_9 -> 0x09
            }
        }

        if (brand == TvBrand.SONY) {
            return when (command) {
                RemoteCommand.POWER -> 0x15
                RemoteCommand.MUTE -> 0x14
                RemoteCommand.VOL_UP -> 0x12
                RemoteCommand.VOL_DOWN -> 0x13
                RemoteCommand.CH_UP -> 0x10
                RemoteCommand.CH_DOWN -> 0x11
                RemoteCommand.UP -> 0x74
                RemoteCommand.DOWN -> 0x75
                RemoteCommand.LEFT -> 0x34
                RemoteCommand.RIGHT -> 0x33
                RemoteCommand.OK -> 0x65
                RemoteCommand.HOME -> 0x60
                RemoteCommand.BACK -> 0x23
                RemoteCommand.MENU -> 0x60
                RemoteCommand.INPUT -> 0x25
                RemoteCommand.DIGIT_0 -> 0x09
                RemoteCommand.DIGIT_1 -> 0x00
                RemoteCommand.DIGIT_2 -> 0x01
                RemoteCommand.DIGIT_3 -> 0x02
                RemoteCommand.DIGIT_4 -> 0x03
                RemoteCommand.DIGIT_5 -> 0x04
                RemoteCommand.DIGIT_6 -> 0x05
                RemoteCommand.DIGIT_7 -> 0x06
                RemoteCommand.DIGIT_8 -> 0x07
                RemoteCommand.DIGIT_9 -> 0x08
            }
        }

        return when (command) {
            RemoteCommand.POWER -> 0x02
            RemoteCommand.MUTE -> 0x07
            RemoteCommand.VOL_UP -> 0x03
            RemoteCommand.VOL_DOWN -> 0x0B
            RemoteCommand.CH_UP -> 0x00
            RemoteCommand.CH_DOWN -> 0x01
            RemoteCommand.UP -> 0x60
            RemoteCommand.DOWN -> 0x61
            RemoteCommand.LEFT -> 0x65
            RemoteCommand.RIGHT -> 0x62
            RemoteCommand.OK -> 0x68
            RemoteCommand.HOME -> 0x79
            RemoteCommand.BACK -> 0x28
            RemoteCommand.MENU -> 0x1A
            RemoteCommand.INPUT -> 0x0A
            RemoteCommand.DIGIT_0 -> 0x10
            RemoteCommand.DIGIT_1 -> 0x11
            RemoteCommand.DIGIT_2 -> 0x12
            RemoteCommand.DIGIT_3 -> 0x13
            RemoteCommand.DIGIT_4 -> 0x14
            RemoteCommand.DIGIT_5 -> 0x15
            RemoteCommand.DIGIT_6 -> 0x16
            RemoteCommand.DIGIT_7 -> 0x17
            RemoteCommand.DIGIT_8 -> 0x18
            RemoteCommand.DIGIT_9 -> 0x19
        }
    }

    fun encodeNec(address: Int, command: Int): IrPattern {
        require(address in 0..0xFF)
        require(command in 0..0xFF)
        val pulses = ArrayList<Int>(68)
        pulses += 9000
        pulses += 4500
        appendNecByte(pulses, address)
        appendNecByte(pulses, address.inv() and 0xFF)
        appendNecByte(pulses, command)
        appendNecByte(pulses, command.inv() and 0xFF)
        pulses += 560
        return IrPattern(frequencyHz = 38_000, patternMicros = pulses.toIntArray())
    }

    fun encodeSirc(command: Int, address: Int, bits: Int = 12): IrPattern {
        require(bits == 12 || bits == 15 || bits == 20)
        require(command in 0..0x7F)
        require(address >= 0)
        val pulses = ArrayList<Int>(bits * 2 + 2)
        pulses += 2400
        pulses += 600
        val payloadBits = when (bits) {
            12 -> 7 to 5
            15 -> 7 to 8
            else -> 7 to 13
        }
        appendSircBits(pulses, command, payloadBits.first)
        appendSircBits(pulses, address, payloadBits.second)
        return IrPattern(frequencyHz = 40_000, patternMicros = pulses.toIntArray())
    }

    fun encodeRc5(address: Int, command: Int, toggle: Boolean = false): IrPattern {
        require(address in 0..0x1F)
        require(command in 0..0x3F)
        var frame = 0
        frame = frame or (1 shl 13)
        frame = frame or (1 shl 12)
        if (toggle) frame = frame or (1 shl 11)
        frame = frame or ((address and 0x1F) shl 6)
        frame = frame or (command and 0x3F)

        val unit = 889
        // Build as alternating levels starting with a mark so ConsumerIrManager accepts it.
        val levels = ArrayList<Boolean>(28) // true = mark
        for (bitIndex in 13 downTo 0) {
            val one = ((frame shr bitIndex) and 1) == 1
            if (one) {
                levels += false // space
                levels += true  // mark
            } else {
                levels += true  // mark
                levels += false // space
            }
        }
        if (levels.isNotEmpty() && !levels.first()) {
            levels.add(0, true)
        }
        val pulses = ArrayList<Int>()
        var current = levels.first()
        var duration = unit
        for (i in 1 until levels.size) {
            if (levels[i] == current) {
                duration += unit
            } else {
                pulses += duration
                current = levels[i]
                duration = unit
            }
        }
        pulses += duration
        return IrPattern(frequencyHz = 36_000, patternMicros = pulses.toIntArray())
    }

    fun encodePanasonic(device: Int, function: Int): IrPattern {
        require(device in 0..0xFFFF)
        require(function in 0..0xFF)
        val pulses = ArrayList<Int>(100)
        pulses += 3500
        pulses += 1750
        val bytes = intArrayOf(
            0x02,
            0x20,
            device and 0xFF,
            (device shr 8) and 0xFF,
            function and 0xFF,
            function.inv() and 0xFF
        )
        for (b in bytes) {
            appendNecStyleByte(pulses, b, mark = 435, zeroSpace = 435, oneSpace = 1300)
        }
        pulses += 435
        return IrPattern(frequencyHz = 35_000, patternMicros = pulses.toIntArray())
    }

    private fun appendNecByte(pulses: MutableList<Int>, value: Int) {
        appendNecStyleByte(pulses, value, mark = 560, zeroSpace = 560, oneSpace = 1690)
    }

    private fun appendNecStyleByte(
        pulses: MutableList<Int>,
        value: Int,
        mark: Int,
        zeroSpace: Int,
        oneSpace: Int
    ) {
        var v = value
        repeat(8) {
            pulses += mark
            pulses += if ((v and 1) == 1) oneSpace else zeroSpace
            v = v shr 1
        }
    }

    private fun appendSircBits(pulses: MutableList<Int>, value: Int, bitCount: Int) {
        var v = value
        repeat(bitCount) {
            pulses += if ((v and 1) == 1) 1200 else 600
            pulses += 600
            v = v shr 1
        }
    }
}
