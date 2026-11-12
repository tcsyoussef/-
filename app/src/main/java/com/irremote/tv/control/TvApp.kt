package com.irremote.tv.control

/**
 * Streaming apps with a shortcut button. Each platform identifies apps differently;
 * null means the app has no known id on that platform.
 */
enum class TvApp(
    val label: String,
    /** Android TV Remote v2 app link (deep link the TV resolves to the installed app). */
    val androidTvLink: String,
    val samsungId: String?,
    val lgId: String?,
    val rokuId: String?
) {
    NETFLIX("Netflix", "https://www.netflix.com/title", "3201907018807", "netflix", "12"),
    YOUTUBE("YouTube", "https://www.youtube.com", "111299001912", "youtube.leanback.v4", "837"),
    PRIME_VIDEO("Prime Video", "https://app.primevideo.com", "3201910019365", "amazon", "13"),
    DISNEY_PLUS("Disney+", "https://www.disneyplus.com", "3201901017640", "com.disney.disneyplus-prod", "291097"),
    SHAHID("Shahid", "https://shahid.mbc.net", null, null, null),
    SPOTIFY("Spotify", "https://open.spotify.com", "3201606009684", "spotify-beehive", "22297")
}
