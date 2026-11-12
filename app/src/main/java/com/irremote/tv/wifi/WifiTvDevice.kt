package com.irremote.tv.wifi

data class WifiTvDevice(
    val ip: String,
    val name: String,
    val model: String = "",
    val portDiscover: Int = 56790,
    val portCommand: Int = 56789
) {
    val displayLabel: String
        get() = if (model.isNotBlank()) "$name ($model) — $ip" else "$name — $ip"
}
