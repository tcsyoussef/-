package com.irremote.tv.net.androidtv

import java.io.ByteArrayOutputStream
import java.io.File
import java.math.BigInteger
import java.security.KeyPairGenerator
import java.security.KeyStore
import java.security.PrivateKey
import java.security.SecureRandom
import java.security.Signature
import java.security.cert.CertificateFactory
import java.security.cert.X509Certificate
import java.security.interfaces.RSAPublicKey
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.TimeZone
import javax.net.ssl.KeyManager
import javax.net.ssl.KeyManagerFactory

/**
 * RSA key + self‑signed X.509 certificate this app presents to Android TVs.
 * The TV remembers the certificate after PIN pairing, so it must persist across launches.
 */
class ClientIdentity(val privateKey: PrivateKey, val certificate: X509Certificate) {

    val publicKey: RSAPublicKey get() = certificate.publicKey as RSAPublicKey

    fun keyManagers(): Array<KeyManager> {
        val ks = KeyStore.getInstance("PKCS12").apply { load(null, null) }
        ks.setKeyEntry(ALIAS, privateKey, PASSWORD, arrayOf(certificate))
        val kmf = KeyManagerFactory.getInstance(KeyManagerFactory.getDefaultAlgorithm())
        kmf.init(ks, PASSWORD)
        return kmf.keyManagers
    }

    companion object {
        private const val ALIAS = "atvremote"
        private val PASSWORD = "atvremote".toCharArray()

        fun loadOrCreate(file: File, commonName: String = "atvremote"): ClientIdentity {
            if (file.exists()) {
                runCatching { return load(file) }
                file.delete()
            }
            val identity = generate(commonName)
            file.parentFile?.mkdirs()
            val ks = KeyStore.getInstance("PKCS12").apply { load(null, null) }
            ks.setKeyEntry(ALIAS, identity.privateKey, PASSWORD, arrayOf(identity.certificate))
            file.outputStream().use { ks.store(it, PASSWORD) }
            return identity
        }

        private fun load(file: File): ClientIdentity {
            val ks = KeyStore.getInstance("PKCS12")
            file.inputStream().use { ks.load(it, PASSWORD) }
            val key = ks.getKey(ALIAS, PASSWORD) as PrivateKey
            val cert = ks.getCertificate(ALIAS) as X509Certificate
            return ClientIdentity(key, cert)
        }

        fun generate(commonName: String = "atvremote"): ClientIdentity {
            val pair = KeyPairGenerator.getInstance("RSA").apply { initialize(2048, SecureRandom()) }.generateKeyPair()
            val algId = Der.seq(Der.oid("1.2.840.113549.1.1.11"), Der.nullValue())
            val name = Der.seq(Der.set(Der.seq(Der.oid("2.5.4.3"), Der.utf8(commonName))))
            val notBefore = Date(System.currentTimeMillis() - 24L * 3600 * 1000)
            val tbs = Der.seq(
                Der.explicit(0, Der.integer(BigInteger.valueOf(2))),
                Der.integer(BigInteger(63, SecureRandom()).add(BigInteger.ONE)),
                algId,
                name,
                Der.seq(Der.utcTime(notBefore), Der.raw(0x17, "491231235959Z".toByteArray(Charsets.US_ASCII))),
                name,
                pair.public.encoded
            )
            val signature = Signature.getInstance("SHA256withRSA").run {
                initSign(pair.private)
                update(tbs)
                sign()
            }
            val der = Der.seq(tbs, algId, Der.bitString(signature))
            val cert = CertificateFactory.getInstance("X.509")
                .generateCertificate(der.inputStream()) as X509Certificate
            return ClientIdentity(pair.private, cert)
        }
    }
}

/** Just enough DER to build a v3 self‑signed certificate. */
internal object Der {
    fun raw(tag: Int, content: ByteArray): ByteArray {
        val out = ByteArrayOutputStream()
        out.write(tag)
        val len = content.size
        when {
            len < 0x80 -> out.write(len)
            len < 0x100 -> { out.write(0x81); out.write(len) }
            len < 0x10000 -> { out.write(0x82); out.write(len shr 8); out.write(len and 0xFF) }
            else -> { out.write(0x83); out.write(len shr 16); out.write((len shr 8) and 0xFF); out.write(len and 0xFF) }
        }
        out.write(content)
        return out.toByteArray()
    }

    fun seq(vararg parts: ByteArray) = raw(0x30, concat(parts))
    fun set(vararg parts: ByteArray) = raw(0x31, concat(parts))
    fun integer(v: BigInteger) = raw(0x02, v.toByteArray())
    fun nullValue() = byteArrayOf(0x05, 0x00)
    fun utf8(s: String) = raw(0x0C, s.toByteArray(Charsets.UTF_8))
    fun bitString(bytes: ByteArray) = raw(0x03, byteArrayOf(0) + bytes)
    fun explicit(n: Int, content: ByteArray) = raw(0xA0 or n, content)

    fun utcTime(date: Date): ByteArray {
        val fmt = SimpleDateFormat("yyMMddHHmmss'Z'", Locale.US).apply { timeZone = TimeZone.getTimeZone("UTC") }
        return raw(0x17, fmt.format(date).toByteArray(Charsets.US_ASCII))
    }

    fun oid(dotted: String): ByteArray {
        val parts = dotted.split('.').map { it.toLong() }
        val out = ByteArrayOutputStream()
        out.write((parts[0] * 40 + parts[1]).toInt())
        for (p in parts.drop(2)) {
            val stack = ArrayList<Int>()
            var v = p
            stack.add((v and 0x7F).toInt())
            v = v shr 7
            while (v > 0) {
                stack.add(((v and 0x7F) or 0x80).toInt())
                v = v shr 7
            }
            stack.asReversed().forEach { out.write(it) }
        }
        return raw(0x06, out.toByteArray())
    }

    private fun concat(parts: Array<out ByteArray>): ByteArray {
        val out = ByteArrayOutputStream()
        parts.forEach { out.write(it) }
        return out.toByteArray()
    }
}
