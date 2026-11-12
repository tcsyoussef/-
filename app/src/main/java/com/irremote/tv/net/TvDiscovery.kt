package com.irremote.tv.net

import java.util.concurrent.ConcurrentHashMap
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit

/**
 * Finds TVs on the local /24 by probing every known remote‑control port in parallel,
 * then classifies each responding host by platform.
 */
class TvDiscovery(
    private val manager: WifiRemoteManager,
    private val threads: Int = 96
) {
    fun scanSubnet(prefix: String, timeoutSeconds: Long = 12): List<DiscoveredTv> =
        scanHosts((1..254).map { "$prefix.$it" }, timeoutSeconds)

    fun scanHosts(hosts: List<String>, timeoutSeconds: Long = 12): List<DiscoveredTv> {
        val open = ConcurrentHashMap<String, MutableSet<Int>>()
        val pool = Executors.newFixedThreadPool(threads)
        try {
            for (ip in hosts) {
                for (port in manager.allPorts()) {
                    pool.execute {
                        if (isPortOpen(ip, port, PROBE_MS)) {
                            open.getOrPut(ip) { ConcurrentHashMap.newKeySet() }.add(port)
                        }
                    }
                }
            }
            pool.shutdown()
            pool.awaitTermination(timeoutSeconds, TimeUnit.SECONDS)
        } finally {
            pool.shutdownNow()
        }
        return open.entries
            .sortedBy { (ip, _) -> ip.substringAfterLast('.').toIntOrNull() ?: 0 }
            .mapNotNull { (ip, ports) -> manager.classify(ip, ports) }
    }

    companion object {
        private const val PROBE_MS = 450
    }
}
