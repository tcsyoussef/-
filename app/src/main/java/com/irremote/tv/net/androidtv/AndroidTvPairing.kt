package com.irremote.tv.net.androidtv

import android.util.Log
import java.io.Closeable
import java.math.BigInteger
import java.security.MessageDigest
import java.security.interfaces.RSAPublicKey
import javax.net.ssl.SSLSocket

/**
 * Android TV Remote v2 pairing ("polo" protocol) on port 6467.
 *
 * [start] makes the TV show a 6‑character hex code; [finish] proves we saw it.
 * After success the TV trusts [identity]'s certificate on the remote port.
 */
class AndroidTvPairing(
    private val ip: String,
    private val port: Int,
    private val identity: ClientIdentity,
    private val clientName: String,
    private val timeoutMs: Int = 10_000
) : Closeable {

    private var socket: SSLSocket? = null

    fun start() {
        val ctx = com.irremote.tv.net.TrustAll.sslContext(identity.keyManagers())
        val s = com.irremote.tv.net.TrustAll.openTls(ctx, ip, port, timeoutMs)
        socket = s
        send(outer().message(10, ProtoWriter().string(1, "atvremote").string(2, clientName)))
        while (true) {
            val msg = read()
            when {
                msg.has(11) -> send(outer().message(20, ProtoWriter()
                    .message(1, hexEncoding())
                    .varint(3, ROLE_INPUT)))
                msg.has(20) -> send(outer().message(30, ProtoWriter()
                    .message(1, hexEncoding())
                    .varint(2, ROLE_INPUT)))
                msg.has(31) -> return
                else -> throw IllegalStateException("Unexpected pairing message from TV")
            }
        }
    }

    fun finish(pin: String) {
        val code = pin.trim().uppercase()
        require(code.length == 6 && code.all { it in "0123456789ABCDEF" }) {
            "Enter the 6-character code shown on the TV"
        }
        val s = socket ?: throw IllegalStateException("Pairing not started")
        val server = s.session.peerCertificates.firstOrNull()?.publicKey as? RSAPublicKey
            ?: throw IllegalStateException("TV did not present an RSA certificate")
        val secret = computeSecret(identity.publicKey, server, code)
        if ((secret[0].toInt() and 0xFF) != code.substring(0, 2).toInt(16)) {
            throw IllegalArgumentException("Wrong code — check the code on the TV and try again")
        }
        send(outer().message(40, ProtoWriter().bytes(1, secret)))
        val msg = read()
        if (!msg.has(41)) throw IllegalStateException("TV did not confirm pairing")
        Log.i(TAG, "Paired with $ip")
    }

    override fun close() {
        runCatching { socket?.close() }
        socket = null
    }

    private fun outer() = ProtoWriter().varint(1, 2).varint(2, STATUS_OK)

    private fun hexEncoding() = ProtoWriter().varint(1, ENCODING_HEX).varint(2, 6)

    private fun send(msg: ProtoWriter) {
        val out = socket!!.outputStream
        out.write(ProtoWriter.frame(msg.toByteArray()))
        out.flush()
    }

    private fun read(): ProtoMessage {
        val frame = ProtoReader.readFrame(socket!!.inputStream)
            ?: throw IllegalStateException("TV closed the pairing connection")
        val msg = ProtoReader.parse(frame)
        val status = msg.varint(2)?.toInt() ?: STATUS_OK
        if (status != STATUS_OK) {
            throw IllegalStateException(
                when (status) {
                    STATUS_BAD_SECRET -> "Wrong code — the TV rejected it"
                    else -> "TV rejected pairing (status $status)"
                }
            )
        }
        return msg
    }

    companion object {
        private const val TAG = "AndroidTvPairing"
        private const val STATUS_OK = 200
        private const val STATUS_BAD_SECRET = 402
        private const val ENCODING_HEX = 3
        private const val ROLE_INPUT = 1

        fun computeSecret(client: RSAPublicKey, server: RSAPublicKey, code: String): ByteArray {
            val sha = MessageDigest.getInstance("SHA-256")
            sha.update(unsigned(client.modulus))
            sha.update(unsigned(client.publicExponent))
            sha.update(unsigned(server.modulus))
            sha.update(unsigned(server.publicExponent))
            sha.update(hexToBytes(code.substring(2)))
            return sha.digest()
        }

        private fun unsigned(v: BigInteger): ByteArray {
            val b = v.toByteArray()
            return if (b.size > 1 && b[0] == 0.toByte()) b.copyOfRange(1, b.size) else b
        }

        private fun hexToBytes(hex: String): ByteArray =
            ByteArray(hex.length / 2) { hex.substring(it * 2, it * 2 + 2).toInt(16).toByte() }
    }
}
