package com.irremote.tv

import org.junit.Assert.assertEquals
import org.junit.Test

class TypingDiffTest {
    @Test
    fun appendSendsOnlyNewText() = assertEquals(listOf("x"), MainActivity.typingDiff("netfli", "netflix"))

    @Test
    fun deleteSendsBackspaces() = assertEquals(listOf("\b", "\b"), MainActivity.typingDiff("abcd", "ab"))

    @Test
    fun autocorrectReplacementDeletesThenTypes() =
        assertEquals(listOf("\b", "\b", "he "), MainActivity.typingDiff("teh", "the "))

    @Test
    fun unchangedSendsNothing() = assertEquals(emptyList<String>(), MainActivity.typingDiff("same", "same"))
}
