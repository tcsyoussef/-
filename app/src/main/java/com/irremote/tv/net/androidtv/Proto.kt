package com.irremote.tv.net.androidtv

import java.io.ByteArrayOutputStream
import java.io.EOFException
import java.io.InputStream
import java.io.OutputStream

/** Minimal protobuf wire encoder covering varint and length‑delimited fields. */
class ProtoWriter {
    private val out = ByteArrayOutputStream()

    fun varint(field: Int, value: Long): ProtoWriter {
        tag(field, 0)
        writeVarint(out, value)
        return this
    }

    fun varint(field: Int, value: Int): ProtoWriter = varint(field, value.toLong())

    fun bytes(field: Int, value: ByteArray): ProtoWriter {
        tag(field, 2)
        writeVarint(out, value.size.toLong())
        out.write(value)
        return this
    }

    fun string(field: Int, value: String): ProtoWriter = bytes(field, value.toByteArray(Charsets.UTF_8))

    fun message(field: Int, value: ProtoWriter): ProtoWriter = bytes(field, value.toByteArray())

    fun toByteArray(): ByteArray = out.toByteArray()

    private fun tag(field: Int, wireType: Int) = writeVarint(out, ((field shl 3) or wireType).toLong())

    companion object {
        fun writeVarint(out: OutputStream, value: Long) {
            var v = value
            while (true) {
                if (v and 0x7FL.inv() == 0L) {
                    out.write(v.toInt())
                    return
                }
                out.write(((v and 0x7F) or 0x80).toInt())
                v = v ushr 7
            }
        }

        /** Length‑prefixed frame used by both the pairing (6467) and remote (6466) sockets. */
        fun frame(payload: ByteArray): ByteArray {
            val out = ByteArrayOutputStream()
            writeVarint(out, payload.size.toLong())
            out.write(payload)
            return out.toByteArray()
        }
    }
}

/** Decoded message: field number → values (Long for varints, ByteArray for length‑delimited). */
class ProtoMessage(private val fields: Map<Int, List<Any>>) {
    fun has(field: Int): Boolean = fields.containsKey(field)
    fun varint(field: Int): Long? = fields[field]?.firstOrNull { it is Long } as? Long
    fun bytes(field: Int): ByteArray? = fields[field]?.firstOrNull { it is ByteArray } as? ByteArray
    fun string(field: Int): String? = bytes(field)?.toString(Charsets.UTF_8)
    fun message(field: Int): ProtoMessage? = bytes(field)?.let { ProtoReader.parse(it) }

    companion object {
        val EMPTY = ProtoMessage(emptyMap())
    }
}

object ProtoReader {
    fun parse(data: ByteArray): ProtoMessage {
        val fields = LinkedHashMap<Int, MutableList<Any>>()
        var pos = 0
        fun readVarint(): Long {
            var shift = 0
            var result = 0L
            while (true) {
                if (pos >= data.size) throw IllegalArgumentException("Truncated varint")
                val b = data[pos++].toInt() and 0xFF
                result = result or ((b and 0x7F).toLong() shl shift)
                if (b and 0x80 == 0) return result
                shift += 7
                if (shift > 63) throw IllegalArgumentException("Varint too long")
            }
        }
        while (pos < data.size) {
            val key = readVarint()
            val field = (key ushr 3).toInt()
            when ((key and 7).toInt()) {
                0 -> fields.getOrPut(field) { mutableListOf() }.add(readVarint())
                1 -> pos += 8
                2 -> {
                    val len = readVarint().toInt()
                    require(len >= 0 && pos + len <= data.size) { "Truncated field $field" }
                    fields.getOrPut(field) { mutableListOf() }.add(data.copyOfRange(pos, pos + len))
                    pos += len
                }
                5 -> pos += 4
                else -> throw IllegalArgumentException("Unsupported wire type in field $field")
            }
        }
        return ProtoMessage(fields)
    }

    /** Reads one varint‑length‑prefixed frame; null at clean end of stream. */
    fun readFrame(input: InputStream, maxSize: Int = 1 shl 20): ByteArray? {
        var shift = 0
        var len = 0L
        var first = true
        while (true) {
            val b = input.read()
            if (b < 0) {
                if (first) return null
                throw EOFException("Stream ended inside frame length")
            }
            first = false
            len = len or ((b and 0x7F).toLong() shl shift)
            if (b and 0x80 == 0) break
            shift += 7
            if (shift > 35) throw IllegalArgumentException("Frame length too long")
        }
        require(len in 0..maxSize) { "Frame too large: $len" }
        val buf = ByteArray(len.toInt())
        var read = 0
        while (read < buf.size) {
            val n = input.read(buf, read, buf.size - read)
            if (n < 0) throw EOFException("Stream ended inside frame")
            read += n
        }
        return buf
    }
}
