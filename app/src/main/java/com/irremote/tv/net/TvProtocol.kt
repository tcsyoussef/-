package com.irremote.tv.net

/** Wi‑Fi control protocols, one per TV platform. */
enum class TvProtocol(val displayName: String) {
    ANDROID_TV("Google TV / Android TV"),
    SAMSUNG("Samsung Smart TV"),
    LG_WEBOS("LG Smart TV"),
    ROKU("Roku"),
    HAIER_VESTEL("Haier Smart TV");

    companion object {
        fun fromName(name: String?): TvProtocol? = entries.firstOrNull { it.name == name }
    }
}

data class DiscoveredTv(
    val ip: String,
    val protocol: TvProtocol,
    val name: String,
    val port: Int = 0,
    /** Other platforms answering at the same IP, tried in order if [protocol] fails. */
    val alternatives: List<TvProtocol> = emptyList()
) {
    val displayLabel: String
        get() = if (name == protocol.displayName) name else "$name · ${protocol.displayName}"
}

/** Default LAN ports; injectable so tests can point at mock servers. */
data class TvPorts(
    val androidTvRemote: Int = 6466,
    val androidTvPairing: Int = 6467,
    val samsungWs: Int = 8001,
    val samsungWss: Int = 8002,
    val lgWs: Int = 3000,
    val lgWss: Int = 3001,
    val roku: Int = 8060,
    val haierDiscover: Int = 56790,
    val cast: Int = 8008
)
