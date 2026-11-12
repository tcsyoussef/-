package com.irremote.tv.wifi

import android.content.Context
import android.net.ConnectivityManager
import android.net.wifi.WifiManager
import java.net.Inet4Address
import java.util.concurrent.Executors
import java.util.concurrent.Future
import java.util.concurrent.TimeUnit

/**
 * Scans the local /24 subnet for Haier SmartCenter TVs answering on :56790/dd.xml.
 */
class WifiTvScanner(
    private val context: Context,
    private val client: HaierWifiClient = HaierWifiClient()
) {
    fun localSubnetPrefix(): String? {
        // Prefer link addresses from ConnectivityManager
        val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val network = cm.activeNetwork ?: return legacyWifiPrefix()
        val props = cm.getLinkProperties(network) ?: return legacyWifiPrefix()
        val ipv4 = props.linkAddresses
            .mapNotNull { it.address as? Inet4Address }
            .firstOrNull { !it.isLoopbackAddress }
            ?: return legacyWifiPrefix()
        val parts = ipv4.hostAddress?.split(".") ?: return null
        if (parts.size != 4) return null
        return "${parts[0]}.${parts[1]}.${parts[2]}"
    }

    @Suppress("DEPRECATION")
    private fun legacyWifiPrefix(): String? {
        val wm = context.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
        val ip = wm.connectionInfo?.ipAddress ?: return null
        if (ip == 0) return null
        val a = ip and 0xff
        val b = ip shr 8 and 0xff
        val c = ip shr 16 and 0xff
        return "$a.$b.$c"
    }

    fun scan(timeoutSeconds: Long = 8): List<WifiTvDevice> {
        val prefix = localSubnetPrefix() ?: return emptyList()
        val pool = Executors.newFixedThreadPool(32)
        val futures = ArrayList<Future<WifiTvDevice?>>(254)
        for (host in 1..254) {
            val ip = "$prefix.$host"
            futures += pool.submit<WifiTvDevice?> {
                client.probe(ip, timeoutMs = 700)
            }
        }
        val found = LinkedHashMap<String, WifiTvDevice>()
        val deadline = System.nanoTime() + TimeUnit.SECONDS.toNanos(timeoutSeconds)
        for (future in futures) {
            val remaining = deadline - System.nanoTime()
            if (remaining <= 0) break
            try {
                val device = future.get(remaining, TimeUnit.NANOSECONDS) ?: continue
                found[device.ip] = device
            } catch (_: Exception) {
                future.cancel(true)
            }
        }
        pool.shutdownNow()
        return found.values.toList()
    }
}
