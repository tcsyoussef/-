package com.irremote.tv.wifi

import com.irremote.tv.ir.RemoteCommand

/**
 * Haier / Vestel SmartCenter LAN key codes.
 *
 * Body formats differ by firmware:
 * - Haier V300S / MB130 often need a trailing `<?xml …?>` after the key tag
 * - Vestel wget scripts use a normal closed `<remote>` document
 * - Older Domoticz scripts omit quotes around the code attribute
 */
object HaierWifiKeyCodes {
    fun codeFor(command: RemoteCommand): Int = when (command) {
        RemoteCommand.POWER -> 1012
        RemoteCommand.MUTE -> 1013
        RemoteCommand.VOL_UP -> 1016
        RemoteCommand.VOL_DOWN -> 1017
        RemoteCommand.CH_UP -> 1032
        RemoteCommand.CH_DOWN -> 1033
        RemoteCommand.UP -> 1020
        RemoteCommand.DOWN -> 1019
        RemoteCommand.LEFT -> 1021
        RemoteCommand.RIGHT -> 1022
        RemoteCommand.OK -> 1053
        RemoteCommand.BACK -> 1010
        // Vestel/HA home; some Domoticz lists call 1048 "menu"
        RemoteCommand.HOME -> 1048
        RemoteCommand.MENU -> 1066
        RemoteCommand.INPUT -> 1056
        RemoteCommand.DIGIT_0 -> 1000
        RemoteCommand.DIGIT_1 -> 1001
        RemoteCommand.DIGIT_2 -> 1002
        RemoteCommand.DIGIT_3 -> 1003
        RemoteCommand.DIGIT_4 -> 1004
        RemoteCommand.DIGIT_5 -> 1005
        RemoteCommand.DIGIT_6 -> 1006
        RemoteCommand.DIGIT_7 -> 1007
        RemoteCommand.DIGIT_8 -> 1008
        RemoteCommand.DIGIT_9 -> 1009
    }

    /** Primary Vestel wget body. */
    fun requestBody(keyCode: Int): String =
        "<?xml version='1.0' ?><remote><key code='$keyCode'/></remote>"

    /**
     * Bodies used by real Haier/Vestel remotes (try in order).
     * First entry is the Haier V300S / MB130 format that many Haier TVs require.
     */
    fun requestBodies(keyCode: Int): List<String> = listOf(
        // Haier V300S API — intentionally malformed trailing XML (required by firmware)
        "<?xml version='1.0' ?><remote><key code='$keyCode'/><?xml version='1.0' ?>",
        requestBody(keyCode),
        "<remote><key code=$keyCode/></remote>",
        "<remote><key code=$keyCode /></remote>",
        "<remote><key code=\"$keyCode\"/></remote>",
        "<?xml version=\"1.0\"?><remote><key code=\"$keyCode\"/></remote>"
    )
}
