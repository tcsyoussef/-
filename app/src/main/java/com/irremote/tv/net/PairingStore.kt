package com.irremote.tv.net

import android.content.Context
import java.util.concurrent.ConcurrentHashMap

/** Remembers pairing tokens and the last TV so reconnects don't prompt again. */
interface PairingStore {
    fun get(key: String): String?
    fun put(key: String, value: String?)

    fun samsungToken(ip: String) = get("samsung_token_$ip")
    fun setSamsungToken(ip: String, token: String?) = put("samsung_token_$ip", token)
    fun lgClientKey(ip: String) = get("lg_key_$ip")
    fun setLgClientKey(ip: String, key: String?) = put("lg_key_$ip", key)

    fun lastTv(): DiscoveredTv? {
        val ip = get("last_ip") ?: return null
        val protocol = TvProtocol.fromName(get("last_protocol")) ?: return null
        return DiscoveredTv(
            ip = ip,
            protocol = protocol,
            name = get("last_name") ?: protocol.displayName,
            port = get("last_port")?.toIntOrNull() ?: 0
        )
    }

    fun setLastTv(tv: DiscoveredTv?) {
        put("last_ip", tv?.ip)
        put("last_protocol", tv?.protocol?.name)
        put("last_name", tv?.name)
        put("last_port", tv?.port?.toString())
    }
}

class SharedPrefsPairingStore(context: Context) : PairingStore {
    private val prefs = context.applicationContext.getSharedPreferences("tv_pairing", Context.MODE_PRIVATE)
    override fun get(key: String): String? = prefs.getString(key, null)
    override fun put(key: String, value: String?) {
        prefs.edit().apply { if (value == null) remove(key) else putString(key, value) }.apply()
    }
}

class InMemoryPairingStore : PairingStore {
    private val map = ConcurrentHashMap<String, String>()
    override fun get(key: String): String? = map[key]
    override fun put(key: String, value: String?) {
        if (value == null) map.remove(key) else map[key] = value
    }
}
