package com.irremote.tv.wifi

import com.irremote.tv.ir.RemoteCommand

/**
 * Haier / Vestel SmartCenter LAN key codes (HTTP POST :56789/apps/SmartCenter).
 * Documented from Haier V300S local API reverse engineering.
 */
object HaierWifiKeyCodes {
    fun codeFor(command: RemoteCommand): Int? = when (command) {
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
        RemoteCommand.MENU -> 1048
        RemoteCommand.HOME -> 1037 // Exit / leave app — closest home-like key
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

    fun requestBody(keyCode: Int): String =
        "<?xml version='1.0' ?><remote><key code='$keyCode'/><?xml version='1.0' ?>"
}
