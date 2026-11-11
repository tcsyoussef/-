package com.irremote.tv.ir

enum class TvBrand(val displayName: String, val protocol: IrProtocol) {
    HAIER("Haier", IrProtocol.NEC),
    HAIER_ALT("Haier Alt", IrProtocol.NEC),
    SAMSUNG("Samsung", IrProtocol.NEC),
    LG("LG", IrProtocol.NEC),
    SONY("Sony", IrProtocol.SIRC),
    PANASONIC("Panasonic", IrProtocol.PANASONIC),
    TCL("TCL", IrProtocol.NEC),
    HISENSE("Hisense", IrProtocol.NEC),
    SHARP("Sharp", IrProtocol.NEC),
    PHILIPS("Philips", IrProtocol.RC5);

    companion object {
        fun fromDisplayName(name: String): TvBrand =
            entries.firstOrNull { it.displayName.equals(name, ignoreCase = true) }
                ?: HAIER
    }
}

enum class IrProtocol {
    NEC,
    SIRC,
    RC5,
    PANASONIC
}
