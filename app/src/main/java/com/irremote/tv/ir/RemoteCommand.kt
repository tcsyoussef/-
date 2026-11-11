package com.irremote.tv.ir

enum class RemoteCommand(val label: String) {
    POWER("Power"),
    MUTE("Mute"),
    VOL_UP("Volume Up"),
    VOL_DOWN("Volume Down"),
    CH_UP("Channel Up"),
    CH_DOWN("Channel Down"),
    UP("Up"),
    DOWN("Down"),
    LEFT("Left"),
    RIGHT("Right"),
    OK("OK"),
    HOME("Home"),
    BACK("Back"),
    MENU("Menu"),
    INPUT("Input"),
    DIGIT_0("0"),
    DIGIT_1("1"),
    DIGIT_2("2"),
    DIGIT_3("3"),
    DIGIT_4("4"),
    DIGIT_5("5"),
    DIGIT_6("6"),
    DIGIT_7("7"),
    DIGIT_8("8"),
    DIGIT_9("9");

    companion object {
        fun digit(value: Int): RemoteCommand {
            require(value in 0..9) { "Digit must be 0..9" }
            return entries.first { it.name == "DIGIT_$value" }
        }
    }
}
