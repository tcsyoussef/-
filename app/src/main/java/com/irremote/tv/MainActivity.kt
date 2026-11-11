package com.irremote.tv

import android.graphics.Color
import android.os.Bundle
import android.view.InputDevice
import android.view.KeyEvent
import android.view.MotionEvent
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.GridLayout
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.button.MaterialButton
import com.irremote.tv.databinding.ActivityMainBinding
import com.irremote.tv.input.IrCommandRunner
import com.irremote.tv.input.PointerController
import com.irremote.tv.input.TouchpadView
import com.irremote.tv.input.TvKeyboardNavigator
import com.irremote.tv.ir.AndroidIrTransmitter
import com.irremote.tv.ir.IrTransmitter
import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.ir.TvBrand

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private lateinit var transmitter: IrTransmitter
    private lateinit var runner: IrCommandRunner
    private var selectedBrand: TvBrand = TvBrand.HAIER
    private var warnedMissingIr = false

    private val keyboardNavigator = TvKeyboardNavigator()
    private val hardwarePointer = PointerController(stepPixels = 36f, minIntervalMs = 70L)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        transmitter = AndroidIrTransmitter(this)
        runner = IrCommandRunner(transmitter)

        setupStatus()
        setupBrandSpinner()
        setupModeToggle()
        bindCoreButtons()
        bindClassicButtons()
        setupTouchpad()
        setupKeyboard()
        showMode(Mode.MOUSE)

        if (!transmitter.hasBuiltInEmitter) {
            showMissingIrDialog()
        }
    }

    private fun setupStatus() {
        if (transmitter.hasBuiltInEmitter) {
            binding.statusText.text = getString(R.string.status_ir_available)
            binding.statusText.setTextColor(getColor(R.color.accent_teal))
            binding.usbStatusText.text = getString(R.string.status_aim_tv)
            binding.usbStatusText.setTextColor(getColor(R.color.text_muted))
        } else {
            binding.statusText.text = getString(R.string.status_ir_unavailable)
            binding.statusText.setTextColor(getColor(R.color.accent_red))
            binding.usbStatusText.text = getString(R.string.status_need_ir_phone)
            binding.usbStatusText.setTextColor(getColor(R.color.accent_amber))
        }
    }

    private fun setupBrandSpinner() {
        val brands = resources.getStringArray(R.array.tv_brands)
        binding.brandSpinner.adapter = ArrayAdapter(
            this,
            R.layout.spinner_item,
            brands
        ).also { it.setDropDownViewResource(R.layout.spinner_dropdown_item) }
        binding.brandSpinner.setSelection(0)
        selectedBrand = TvBrand.HAIER
        binding.brandSpinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
                selectedBrand = TvBrand.fromDisplayName(brands[position])
            }

            override fun onNothingSelected(parent: AdapterView<*>?) = Unit
        }
    }

    private fun setupModeToggle() {
        binding.modeToggle.addOnButtonCheckedListener { _, checkedId, isChecked ->
            if (!isChecked) return@addOnButtonCheckedListener
            when (checkedId) {
                R.id.modeMouse -> showMode(Mode.MOUSE)
                R.id.modeKeyboard -> showMode(Mode.KEYBOARD)
                R.id.modeClassic -> showMode(Mode.CLASSIC)
            }
        }
    }

    private fun showMode(mode: Mode) {
        binding.touchpadInclude.root.visibility = if (mode == Mode.MOUSE) View.VISIBLE else View.GONE
        binding.keyboardInclude.root.visibility = if (mode == Mode.KEYBOARD) View.VISIBLE else View.GONE
        binding.classicPanel.visibility = if (mode == Mode.CLASSIC) View.VISIBLE else View.GONE
    }

    private fun bindCoreButtons() {
        listOf(
            binding.btnPower to RemoteCommand.POWER,
            binding.btnMute to RemoteCommand.MUTE,
            binding.btnVolUp to RemoteCommand.VOL_UP,
            binding.btnVolDown to RemoteCommand.VOL_DOWN,
            binding.btnChUp to RemoteCommand.CH_UP,
            binding.btnChDown to RemoteCommand.CH_DOWN
        ).forEach { (button, command) ->
            button.setOnClickListener { sendSingle(command) }
        }
    }

    private fun bindClassicButtons() {
        listOf(
            binding.btnUp to RemoteCommand.UP,
            binding.btnDown to RemoteCommand.DOWN,
            binding.btnLeft to RemoteCommand.LEFT,
            binding.btnRight to RemoteCommand.RIGHT,
            binding.btnOk to RemoteCommand.OK,
            binding.btnHome to RemoteCommand.HOME,
            binding.btnBack to RemoteCommand.BACK,
            binding.btnMenu to RemoteCommand.MENU,
            binding.btn0 to RemoteCommand.DIGIT_0,
            binding.btn1 to RemoteCommand.DIGIT_1,
            binding.btn2 to RemoteCommand.DIGIT_2,
            binding.btn3 to RemoteCommand.DIGIT_3,
            binding.btn4 to RemoteCommand.DIGIT_4,
            binding.btn5 to RemoteCommand.DIGIT_5,
            binding.btn6 to RemoteCommand.DIGIT_6,
            binding.btn7 to RemoteCommand.DIGIT_7,
            binding.btn8 to RemoteCommand.DIGIT_8,
            binding.btn9 to RemoteCommand.DIGIT_9
        ).forEach { (button, command) ->
            button.setOnClickListener { sendSingle(command) }
        }
    }

    private fun setupTouchpad() {
        val pad = binding.touchpadInclude
        pad.touchpadView.listener = object : TouchpadView.Listener {
            override fun onIrCommands(commands: List<RemoteCommand>) {
                sendSequence(commands, announce = false)
            }

            override fun onStatus(message: String) {
                binding.lastCommandText.text = message
                binding.lastCommandText.setTextColor(getColor(R.color.accent_teal))
            }
        }
        pad.btnPadOk.setOnClickListener { sendSingle(RemoteCommand.OK) }
        pad.btnPadBack.setOnClickListener { sendSingle(RemoteCommand.BACK) }
        pad.btnPadHome.setOnClickListener { sendSingle(RemoteCommand.HOME) }
    }

    private fun setupKeyboard() {
        val kb = binding.keyboardInclude
        kb.btnResetKeyboardCursor.setOnClickListener {
            keyboardNavigator.resetCursor()
            updateKeyboardCursorLabel()
            Toast.makeText(this, R.string.reset_tv_keyboard_cursor, Toast.LENGTH_SHORT).show()
        }
        updateKeyboardCursorLabel()
        buildKeyboardGrid(kb.keyboardGrid)
    }

    private fun buildKeyboardGrid(grid: GridLayout) {
        grid.removeAllViews()
        val rows = TvKeyboardNavigator.DEFAULT_LAYOUT
        rows.forEach { row ->
            row.forEach { ch ->
                val label = when (ch) {
                    ' ' -> "SPC"
                    '↵' -> "ENT"
                    else -> ch.toString()
                }
                val button = MaterialButton(this, null, com.google.android.material.R.attr.materialButtonOutlinedStyle).apply {
                    text = label
                    textSize = 12f
                    minimumHeight = 0
                    minHeight = 0
                    insetTop = 0
                    insetBottom = 0
                    setPadding(4, 8, 4, 8)
                    layoutParams = GridLayout.LayoutParams().apply {
                        width = 0
                        height = ViewGroup.LayoutParams.WRAP_CONTENT
                        columnSpec = GridLayout.spec(GridLayout.UNDEFINED, 1f)
                        setMargins(2, 2, 2, 2)
                    }
                    setOnClickListener { onSoftKey(ch) }
                }
                grid.addView(button)
            }
        }
        // Extra functional keys
        addExtraKey(grid, "⌫") { onSoftKey('\b') }
        addExtraKey(grid, "OK") { sendSingle(RemoteCommand.OK) }
        addExtraKey(grid, "Back") { sendSingle(RemoteCommand.BACK) }
    }

    private fun addExtraKey(grid: GridLayout, label: String, onClick: () -> Unit) {
        val button = MaterialButton(this, null, com.google.android.material.R.attr.materialButtonStyle).apply {
            text = label
            textSize = 12f
            layoutParams = GridLayout.LayoutParams().apply {
                width = 0
                height = ViewGroup.LayoutParams.WRAP_CONTENT
                columnSpec = GridLayout.spec(GridLayout.UNDEFINED, 2f)
                setMargins(2, 2, 2, 2)
            }
            setOnClickListener { onClick() }
        }
        grid.addView(button)
    }

    private fun onSoftKey(ch: Char) {
        if (!ensureIr()) return
        if (runner.isBusy()) {
            Toast.makeText(this, R.string.typing_busy, Toast.LENGTH_SHORT).show()
            return
        }
        // Always navigate the TV on-screen keyboard with real IR arrows + OK.
        val commands = keyboardNavigator.typeCharacter(ch)
        if (commands.isEmpty()) return
        sendSequence(commands) {
            updateKeyboardCursorLabel()
        }
        binding.lastCommandText.text = "Keyboard → '$ch' (${commands.size} IR steps)"
        binding.lastCommandText.setTextColor(getColor(R.color.accent_teal))
    }

    private fun updateKeyboardCursorLabel() {
        binding.keyboardInclude.keyboardCursorText.text = getString(
            R.string.keyboard_cursor_fmt,
            keyboardNavigator.row + 1,
            keyboardNavigator.col + 1,
            keyboardNavigator.currentChar().toString()
        )
    }

    private fun sendSingle(command: RemoteCommand) {
        if (!ensureIr()) return
        when (val result = transmitter.transmit(selectedBrand, command)) {
            is TransmitResult.Sent -> {
                binding.lastCommandText.text =
                    getString(R.string.last_command, "${selectedBrand.displayName} ${command.label} (IR sent)")
                binding.lastCommandText.setTextColor(getColor(R.color.accent_teal))
            }
            is TransmitResult.Failed -> {
                binding.lastCommandText.text = result.reason
                binding.lastCommandText.setTextColor(Color.parseColor("#F87171"))
                Toast.makeText(this, result.reason, Toast.LENGTH_LONG).show()
            }
        }
    }

    private fun sendSequence(commands: List<RemoteCommand>, announce: Boolean = true, onDone: (() -> Unit)? = null) {
        if (!ensureIr()) return
        if (commands.isEmpty()) {
            onDone?.invoke()
            return
        }
        if (announce) {
            binding.lastCommandText.text =
                "Sending ${commands.size} IR step(s): ${commands.joinToString(" → ") { it.label }}"
            binding.lastCommandText.setTextColor(getColor(R.color.accent_teal))
        }
        runner.enqueue(selectedBrand, commands, onEach = { cmd, result ->
            if (result is TransmitResult.Failed) {
                Toast.makeText(this, result.reason, Toast.LENGTH_LONG).show()
            } else if (!announce) {
                binding.lastCommandText.text = "IR → ${cmd.label}"
                binding.lastCommandText.setTextColor(getColor(R.color.accent_teal))
            }
        }, onDone = onDone)
    }

    private fun ensureIr(): Boolean {
        if (transmitter.hasBuiltInEmitter) return true
        if (!warnedMissingIr) showMissingIrDialog() else {
            Toast.makeText(this, R.string.status_need_ir_phone, Toast.LENGTH_LONG).show()
        }
        return false
    }

    private fun showMissingIrDialog() {
        warnedMissingIr = true
        AlertDialog.Builder(this)
            .setTitle(R.string.no_ir_title)
            .setMessage(R.string.no_ir_message)
            .setPositiveButton(android.R.string.ok, null)
            .show()
    }

    /** Physical keyboard → real IR commands. */
    override fun dispatchKeyEvent(event: KeyEvent): Boolean {
        if (event.action != KeyEvent.ACTION_DOWN || event.repeatCount > 0) {
            return super.dispatchKeyEvent(event)
        }
        val command = when (event.keyCode) {
            KeyEvent.KEYCODE_DPAD_UP -> RemoteCommand.UP
            KeyEvent.KEYCODE_DPAD_DOWN -> RemoteCommand.DOWN
            KeyEvent.KEYCODE_DPAD_LEFT -> RemoteCommand.LEFT
            KeyEvent.KEYCODE_DPAD_RIGHT -> RemoteCommand.RIGHT
            KeyEvent.KEYCODE_ENTER, KeyEvent.KEYCODE_DPAD_CENTER, KeyEvent.KEYCODE_NUMPAD_ENTER ->
                RemoteCommand.OK
            KeyEvent.KEYCODE_BACK, KeyEvent.KEYCODE_ESCAPE, KeyEvent.KEYCODE_DEL ->
                RemoteCommand.BACK
            KeyEvent.KEYCODE_HOME -> RemoteCommand.HOME
            KeyEvent.KEYCODE_VOLUME_UP -> RemoteCommand.VOL_UP
            KeyEvent.KEYCODE_VOLUME_DOWN -> RemoteCommand.VOL_DOWN
            KeyEvent.KEYCODE_0, KeyEvent.KEYCODE_NUMPAD_0 -> RemoteCommand.DIGIT_0
            KeyEvent.KEYCODE_1, KeyEvent.KEYCODE_NUMPAD_1 -> RemoteCommand.DIGIT_1
            KeyEvent.KEYCODE_2, KeyEvent.KEYCODE_NUMPAD_2 -> RemoteCommand.DIGIT_2
            KeyEvent.KEYCODE_3, KeyEvent.KEYCODE_NUMPAD_3 -> RemoteCommand.DIGIT_3
            KeyEvent.KEYCODE_4, KeyEvent.KEYCODE_NUMPAD_4 -> RemoteCommand.DIGIT_4
            KeyEvent.KEYCODE_5, KeyEvent.KEYCODE_NUMPAD_5 -> RemoteCommand.DIGIT_5
            KeyEvent.KEYCODE_6, KeyEvent.KEYCODE_NUMPAD_6 -> RemoteCommand.DIGIT_6
            KeyEvent.KEYCODE_7, KeyEvent.KEYCODE_NUMPAD_7 -> RemoteCommand.DIGIT_7
            KeyEvent.KEYCODE_8, KeyEvent.KEYCODE_NUMPAD_8 -> RemoteCommand.DIGIT_8
            KeyEvent.KEYCODE_9, KeyEvent.KEYCODE_NUMPAD_9 -> RemoteCommand.DIGIT_9
            else -> {
                val ch = event.unicodeChar.toChar()
                if (ch.isLetter() || ch == ' ' || ch == '.') {
                    onSoftKey(ch.lowercaseChar())
                    return true
                }
                null
            }
        }
        if (command != null) {
            sendSingle(command)
            return true
        }
        return super.dispatchKeyEvent(event)
    }

    /** Hardware / Bluetooth mouse → real IR D-pad steps. */
    override fun onGenericMotionEvent(event: MotionEvent): Boolean {
        if (event.source and InputDevice.SOURCE_CLASS_POINTER == 0) {
            return super.onGenericMotionEvent(event)
        }
        when (event.actionMasked) {
            MotionEvent.ACTION_HOVER_MOVE, MotionEvent.ACTION_MOVE -> {
                val dx = event.getAxisValue(MotionEvent.AXIS_RELATIVE_X)
                    .takeIf { it != 0f } ?: (event.x - (event.historySize.takeIf { it > 0 }?.let {
                        event.getHistoricalX(0)
                    } ?: event.x))
                val dy = event.getAxisValue(MotionEvent.AXIS_RELATIVE_Y)
                    .takeIf { it != 0f } ?: 0f
                // Prefer relative axes from mouse; fall back to scroll axes
                val relX = if (event.device != null &&
                    (event.source and InputDevice.SOURCE_MOUSE) == InputDevice.SOURCE_MOUSE
                ) {
                    event.getAxisValue(MotionEvent.AXIS_RELATIVE_X)
                } else dx
                val relY = if ((event.source and InputDevice.SOURCE_MOUSE) == InputDevice.SOURCE_MOUSE) {
                    event.getAxisValue(MotionEvent.AXIS_RELATIVE_Y)
                } else dy

                val useX = if (relX != 0f) relX else event.getAxisValue(MotionEvent.AXIS_HSCROLL) * 40f
                val useY = if (relY != 0f) relY else event.getAxisValue(MotionEvent.AXIS_VSCROLL) * 40f
                val commands = hardwarePointer.onMove(useX, useY)
                if (commands.isNotEmpty()) {
                    sendSequence(commands, announce = false)
                    return true
                }
            }
            MotionEvent.ACTION_SCROLL -> {
                val v = event.getAxisValue(MotionEvent.AXIS_VSCROLL)
                hardwarePointer.onScroll(v)?.let {
                    sendSingle(it)
                    return true
                }
            }
            MotionEvent.ACTION_BUTTON_PRESS -> {
                if (event.actionButton == MotionEvent.BUTTON_PRIMARY) {
                    sendSingle(hardwarePointer.onClick())
                    return true
                }
            }
        }
        return super.onGenericMotionEvent(event)
    }

    private enum class Mode { MOUSE, KEYBOARD, CLASSIC }
}
