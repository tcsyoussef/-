package com.irremote.tv.net

import com.irremote.tv.net.androidtv.AndroidTvPairing
import com.irremote.tv.net.androidtv.ClientIdentity
import com.irremote.tv.net.androidtv.ProtoMessage
import com.irremote.tv.net.androidtv.ProtoReader
import com.irremote.tv.net.androidtv.ProtoWriter
import java.io.OutputStream
import java.security.SecureRandom
import java.security.interfaces.RSAPublicKey
import java.util.Collections
import java.util.concurrent.CopyOnWriteArrayList
import javax.net.ssl.SSLServerSocket
import javax.net.ssl.SSLSocket

/**
 * Behaves like an Android TV's remote service: polo pairing on one TLS port (client cert required,
 * code checked against both RSA keys) and the remote channel on another that only admits paired certs.
 */
class MockAndroidTv : AutoCloseable {
    private val identity = ClientIdentity.generate("mock-android-tv")
    private val ctx = TrustAll.sslContext(identity.keyManagers())
    private val pairingServer = server()
    private val remoteServer = server()
    private val trusted = Collections.synchronizedSet(HashSet<String>())

    val pairingPort: Int get() = pairingServer.localPort
    val remotePort: Int get() = remoteServer.localPort

    @Volatile var shownCode: String? = null
    val keyCodes = CopyOnWriteArrayList<Int>()
    val batchTexts = CopyOnWriteArrayList<String>()
    val appLinks = CopyOnWriteArrayList<String>()
    @Volatile var sendImeFocus = false

    private fun server(): SSLServerSocket =
        (ctx.serverSocketFactory.createServerSocket(0) as SSLServerSocket).apply { needClientAuth = true }

    init {
        thread { while (!pairingServer.isClosed) runCatching { handlePairing(pairingServer.accept() as SSLSocket) } }
        thread { while (!remoteServer.isClosed) runCatching { handleRemote(remoteServer.accept() as SSLSocket) } }
    }

    private fun thread(block: () -> Unit) = Thread(block).apply { isDaemon = true }.start()

    private fun clientKey(socket: SSLSocket): RSAPublicKey {
        socket.startHandshake()
        return socket.session.peerCertificates.first().publicKey as RSAPublicKey
    }

    private fun write(out: OutputStream, msg: ProtoWriter) {
        out.write(ProtoWriter.frame(msg.toByteArray()))
        out.flush()
    }

    private fun outer(status: Int = 200) = ProtoWriter().varint(1, 2).varint(2, status)

    private fun handlePairing(socket: SSLSocket) = socket.use {
        val client = clientKey(socket)
        val input = socket.inputStream
        val out = socket.outputStream
        while (true) {
            val msg = ProtoReader.parse(ProtoReader.readFrame(input) ?: return)
            when {
                msg.has(10) -> write(out, outer().message(11, ProtoWriter().string(1, "mock")))
                msg.has(20) -> write(out, outer().message(20, ProtoWriter()
                    .message(1, ProtoWriter().varint(1, 3).varint(2, 6)).varint(3, 1)))
                msg.has(30) -> {
                    val suffix = "%04X".format(SecureRandom().nextInt(0x10000))
                    val hash = AndroidTvPairing.computeSecret(client, identity.publicKey, "00$suffix")
                    shownCode = "%02X".format(hash[0].toInt() and 0xFF) + suffix
                    write(out, outer().message(31, ProtoWriter()))
                }
                msg.has(40) -> {
                    val code = shownCode ?: return
                    val expected = AndroidTvPairing.computeSecret(client, identity.publicKey, code)
                    if (msg.message(40)?.bytes(1)?.contentEquals(expected) == true) {
                        trusted += client.modulus.toString(16)
                        write(out, outer().message(41, ProtoWriter().bytes(1, expected)))
                    } else {
                        write(out, outer(402))
                    }
                }
            }
        }
    }

    private fun handleRemote(socket: SSLSocket) = thread {
        socket.use {
            val client = clientKey(socket)
            if (client.modulus.toString(16) !in trusted) return@thread
            val input = socket.inputStream
            val out = socket.outputStream
            write(out, ProtoWriter().message(1, ProtoWriter().varint(1, 622)
                .message(2, ProtoWriter().string(1, "MockTV").string(2, "Mock"))))
            while (true) {
                val msg: ProtoMessage = ProtoReader.parse(ProtoReader.readFrame(input) ?: return@thread)
                when {
                    msg.has(1) -> write(out, ProtoWriter().message(2, ProtoWriter().varint(1, 622)))
                    msg.has(2) -> {
                        write(out, ProtoWriter().message(40, ProtoWriter().varint(1, 1)))
                        write(out, ProtoWriter().message(8, ProtoWriter().varint(1, 7)))
                        if (sendImeFocus) {
                            write(out, ProtoWriter().message(20, ProtoWriter()
                                .message(1, ProtoWriter().varint(1, 5))
                                .message(2, ProtoWriter().varint(1, 9))))
                        }
                    }
                    msg.has(10) -> msg.message(10)?.varint(1)?.let { keyCodes += it.toInt() }
                    msg.has(21) -> msg.message(21)?.message(3)?.message(2)?.string(3)?.let { batchTexts += it }
                    msg.has(90) -> msg.message(90)?.string(1)?.let { appLinks += it }
                }
            }
        }
    }

    override fun close() {
        runCatching { pairingServer.close() }
        runCatching { remoteServer.close() }
    }
}
