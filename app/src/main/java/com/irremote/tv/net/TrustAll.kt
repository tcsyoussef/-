package com.irremote.tv.net

import android.annotation.SuppressLint
import okhttp3.OkHttpClient
import java.net.InetSocketAddress
import java.net.Socket
import java.security.cert.X509Certificate
import java.util.concurrent.TimeUnit
import javax.net.ssl.KeyManager
import javax.net.ssl.SSLContext
import javax.net.ssl.SSLSocket
import javax.net.ssl.X509TrustManager

/**
 * TVs on the LAN use self‑signed certificates, so certificate chains can't be verified.
 * Trust is established by the on‑TV pairing prompt instead.
 */
object TrustAll {
    @SuppressLint("CustomX509TrustManager", "TrustAllX509TrustManager")
    val trustManager: X509TrustManager = object : X509TrustManager {
        override fun checkClientTrusted(chain: Array<out X509Certificate>?, authType: String?) = Unit
        override fun checkServerTrusted(chain: Array<out X509Certificate>?, authType: String?) = Unit
        override fun getAcceptedIssuers(): Array<X509Certificate> = emptyArray()
    }

    fun sslContext(keyManagers: Array<KeyManager>? = null): SSLContext =
        SSLContext.getInstance("TLS").apply { init(keyManagers, arrayOf(trustManager), null) }

    fun okHttp(timeoutMs: Long = 5000): OkHttpClient {
        val ctx = sslContext()
        return OkHttpClient.Builder()
            .sslSocketFactory(ctx.socketFactory, trustManager)
            .hostnameVerifier { _, _ -> true }
            .connectTimeout(timeoutMs, TimeUnit.MILLISECONDS)
            .readTimeout(timeoutMs, TimeUnit.MILLISECONDS)
            .writeTimeout(timeoutMs, TimeUnit.MILLISECONDS)
            .pingInterval(20, TimeUnit.SECONDS)
            .build()
    }

    fun openTls(ctx: SSLContext, ip: String, port: Int, timeoutMs: Int): SSLSocket {
        val raw = Socket()
        try {
            raw.connect(InetSocketAddress(ip, port), timeoutMs)
            val ssl = ctx.socketFactory.createSocket(raw, ip, port, true) as SSLSocket
            ssl.soTimeout = timeoutMs
            ssl.startHandshake()
            return ssl
        } catch (error: Exception) {
            runCatching { raw.close() }
            throw error
        }
    }
}

fun isPortOpen(ip: String, port: Int, timeoutMs: Int): Boolean = try {
    Socket().use { it.connect(InetSocketAddress(ip, port), timeoutMs); true }
} catch (_: Exception) {
    false
}
