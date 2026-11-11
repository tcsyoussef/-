package com.irremote.tv

import android.graphics.Color
import android.os.Bundle
import android.os.Handler
import android.os.Looper
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
import com.irremote.tv.control.ControlLink
import com.irremote.tv.control.TvCommandRouter
import com.irremote.tv.databinding.ActivityMainBinding
import com.irremote.tv.input.IrCommandRunner
import com.irremote.tv.input.PointerController
import com.irremote.tv.input.TouchpadView
import com.irremote.tv.input.TvKeyboardNavigator
import com.irremote.tv.ir.AndroidIrTransmitter
import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.ir.TvBrand
import com.irremote.tv.wifi.HaierWifiClient
import com.irremote.tv.wifi.WifiTvDevice
import com.irremote.tv.wifi.WifiTvScanner
import java.util.concurrent.Executors

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private lateinit var router: TvCommandRouter
    private lateinit var wifiClient: HaierWifiClient
    private lateinit var runner: IrCommandRunner
    private var selectedBrand: TvBrand = TvBrand.HAIER
    private var warnedMissingIr = false

    private val keyboardNavigator = TvKeyboardNavigator()
    private val hardwarePointer = PointerController(stepPixels = 36f, minIntervalMs = 70L)
    private val ioExecutor = Executors.newSingleThreadExecutor()
    private val mainHandler = Handler(Looper.getMainLooper())

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val ir = AndroidIrTransmitter(this)
        wifiClient = HaierWifiClient()
        router = TvCommandRouter(ir, wifiClient)
        runner = IrCommandRunner(sender = { brand, command -> router.send(brand, command) })

        setupStatus()
        setupLinkToggle()
        setupWifiPanel()
        setupBrandSpinner()
        setupModeToggle()
        bindCoreButtons()
        bindClassicButtons()
        setupTouchpad()
        setupKeyboard()
        showMode(Mode.MOUSE)
        applyLink(ControlLink.IR)

        if (!ir.hasBuiltInEmitter) {
            // Prefer Wi‑Fi when phone has no IR
            binding.linkToggle.check(R.id.linkWifi)
        }
    }

    private fun setupStatus() {
        refreshStatusBanner()
    }

    private fun refreshStatusBanner() {
        when (router.link) {
            ControlLink.IR -> {
                if (router.statusReady()) {
                    binding.statusText.text = getString(R.string.status_ir_available)
                    binding.statusText.setTextColor(getColor(R.color.accent_teal))
                    binding.usbStatusText.text = getString(R.string.status_aim_tv)
                } else {
                    binding.statusText.text = getString(R.string.status_ir_unavailable)
                    binding.statusText.setTextColor(getColor(R.color.accent_red))
                    binding.usbStatusText.text = getString(R.string.status_need_ir_phone)
                }
                binding.usbStatusText.setTextColor(getColor(R.color.text_muted))
            }
            ControlLink.WIFI -> {
                binding.statusText.text = getString(R.string.status_wifi_mode)
                binding.statusText.setTextColor(getColor(R.color.accent_teal))
                val device = wifiClient.device
                if (device != null) {
                    binding.usbStatusText.text = getString(R.string.wifi_connected_fmt, device.displayLabel)
                    binding.usbStatusText.setTextColor(getColor(R.color.accent_teal))
                    binding.wifiInclude.wifiStatusText.text =
                        getString(R.string.wifi_connected_fmt, device.displayLabel)
                    binding.wifiInclude.wifiStatusText.setTextColor(getColor(R.color.accent_teal))
                } else {
                    binding.usbStatusText.text = getString(R.string.wifi_not_connected)
                    binding.usbStatusText.setTextColor(getColor(R.color.accent_amber))
                    binding.wifiInclude.wifiStatusText.text = getString(R.string.wifi_not_connected)
                    binding.wifiInclude.wifiStatusText.setTextColor(getColor(R.color.accent_amber))
                }
            }
        }
    }

    private fun setupLinkToggle() {
        binding.linkToggle.addOnButtonCheckedListener { _, checkedId, isChecked ->
            if (!isChecked) return@addOnButtonCheckedListener
            when (checkedId) {
                R.id.linkIr -> applyLink(ControlLink.IR)
                R.id.linkWifi -> applyLink(ControlLink.WIFI)
            }
        }
    }

    private fun applyLink(link: ControlLink) {
        router.link = link
        binding.wifiInclude.root.visibility = if (link == ControlLink.WIFI) View.VISIBLE else View.GONE
        // Brand IR codes matter for IR; Wi‑Fi uses Haier SmartCenter codes
        val showBrand = link == ControlLink.IR
        binding.brandLabel.visibility = if (showBrand) View.VISIBLE else View.GONE
        binding.brandSpinner.visibility = if (showBrand) View.VISIBLE else View.GONE
        refreshStatusBanner()
        if (link == ControlLink.IR && !router.statusReady() && !warnedMissingIr) {
            showMissingIrDialog()
        }
    }

    private fun setupWifiPanel() {
        val wifi = binding.wifiInclude
        wifi.btnWifiConnect.setOnClickListener {
            val ip = wifi.wifiIpInput.text?.toString().orEmpty()
            connectWifi(ip)
        }
        wifi.btnWifiScan.setOnClickListener { scanWifi() }
    }

    private fun scanWifi() {
        val wifi = binding.wifiInclude
        wifi.wifiScanResultText.text = getString(R.string.wifi_scanning)
        wifi.wifiDeviceList.removeAllViews()
        wifi.btnWifiScan.isEnabled = false
        ioExecutor.execute {
            val devices = try {
                WifiTvScanner(this, wifiClient).scan()
            } catch (_: Exception) {
                emptyList()
            }
            mainHandler.post {
                wifi.btnWifiScan.isEnabled = true
                wifi.wifiDeviceList.removeAllViews()
                if (devices.isEmpty()) {
                    wifi.wifiScanResultText.text = getString(R.string.wifi_scan_none)
                } else {
                    wifi.wifiScanResultText.text = getString(R.string.wifi_scan_found, devices.size)
                    devices.forEach { device -> addWifiDeviceRow(device) }
                }
            }
        }
    }

    private fun addWifiDeviceRow(device: WifiTvDevice) {
        val button = MaterialButton(this, null, com.google.android.material.R.attr.materialButtonOutlinedStyle).apply {
            text = device.displayLabel
            isAllCaps = false
            setOnClickListener {
                binding.wifiInclude.wifiIpInput.setText(device.ip)
                connectWifi(device.ip)
            }
        }
        binding.wifiInclude.wifiDeviceList.addView(button)
    }

    private fun connectWifi(ip: String) {
        binding.wifiInclude.wifiStatusText.text = getString(R.string.wifi_connecting)
        ioExecutor.execute {
            val result = wifiClient.connect(ip)
            mainHandler.post {
                result.onSuccess {
                    Toast.makeText(this, getString(R.string.wifi_connected_fmt, it.displayLabel), Toast.LENGTH_SHORT).show()
                    refreshStatusBanner()
                }.onFailure {
                    Toast.makeText(this, it.message ?: "Connect failed", Toast.LENGTH_LONG).show()
                    refreshStatusBanner()
                }
            }
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
        TvKeyboardNavigator.DEFAULT_LAYOUT.forEach { row ->
            row.forEach { ch ->
                val label = when (ch) {
                    ' ' -> "SPC"
                    '↵' -> "ENT"
                    else -> ch.uppercaseChar().toString()
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
        if (!ensureTransport()) return
        if (runner.isBusy()) {
            Toast.makeText(this, R.string.typing_busy, Toast.LENGTH_SHORT).show()
            return
        }
        val commands = keyboardNavigator.typeCharacter(ch)
        if (commands.isEmpty()) return
        sendSequence(commands) { updateKeyboardCursorLabel() }
        binding.lastCommandText.text = "Keyboard → '$ch' (${commands.size} steps)"
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
        if (!ensureTransport()) return
        ioExecutor.execute {
            val result = router.send(selectedBrand, command)
            mainHandler.post { showResult(command, result) }
        }
    }

    private fun showResult(command: RemoteCommand, result: TransmitResult) {
        when (result) {
            is TransmitResult.Sent -> {
                val via = if (router.link == ControlLink.WIFI) "Wi‑Fi" else "IR"
                binding.lastCommandText.text =
                    getString(R.string.last_command, "${command.label} ($via)")
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
        if (!ensureTransport()) return
        if (commands.isEmpty()) {
            onDone?.invoke()
            return
        }
        if (announce) {
            binding.lastCommandText.text =
                "Sending ${commands.size} step(s): ${commands.joinToString(" → ") { it.label }}"
            binding.lastCommandText.setTextColor(getColor(R.color.accent_teal))
        }
        // Run network/IR off main for Wi‑Fi; runner already spaces calls
        ioExecutor.execute {
            val gap = 120L
            for ((index, command) in commands.withIndex()) {
                val result = router.send(selectedBrand, command)
                mainHandler.post {
                    if (result is TransmitResult.Failed) {
                        Toast.makeText(this, result.reason, Toast.LENGTH_LONG).show()
                    } else if (!announce) {
                        binding.lastCommandText.text = "→ ${command.label}"
                        binding.lastCommandText.setTextColor(getColor(R.color.accent_teal))
                    }
                }
                if (result is TransmitResult.Failed) {
                    mainHandler.post { onDone?.invoke() }
                    return@execute
                }
                if (index < commands.lastIndex) Thread.sleep(gap)
            }
            mainHandler.post { onDone?.invoke() }
        }
    }

    private fun ensureTransport(): Boolean {
        if (router.statusReady()) return true
        return when (router.link) {
            ControlLink.IR -> {
                if (!warnedMissingIr) showMissingIrDialog() else {
                    Toast.makeText(this, R.string.status_need_ir_phone, Toast.LENGTH_LONG).show()
                }
                false
            }
            ControlLink.WIFI -> {
                Toast.makeText(this, R.string.need_wifi_connect, Toast.LENGTH_LONG).show()
                false
            }
        }
    }

    private fun showMissingIrDialog() {
        warnedMissingIr = true
        AlertDialog.Builder(this)
            .setTitle(R.string.no_ir_title)
            .setMessage(
                getString(R.string.no_ir_message) +
                    "\n\nOr switch to Wi‑Fi mode if your Haier TV is on the same network."
            )
            .setPositiveButton(android.R.string.ok, null)
            .setNeutralButton(R.string.link_wifi) { _, _ ->
                binding.linkToggle.check(R.id.linkWifi)
            }
            .show()
    }

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

    override fun onGenericMotionEvent(event: MotionEvent): Boolean {
        if (event.source and InputDevice.SOURCE_CLASS_POINTER == 0) {
            return super.onGenericMotionEvent(event)
        }
        when (event.actionMasked) {
            MotionEvent.ACTION_HOVER_MOVE, MotionEvent.ACTION_MOVE -> {
                val relX = event.getAxisValue(MotionEvent.AXIS_RELATIVE_X)
                val relY = event.getAxisValue(MotionEvent.AXIS_RELATIVE_Y)
                val useX = if (relX != 0f) relX else event.getAxisValue(MotionEvent.AXIS_HSCROLL) * 40f
                val useY = if (relY != 0f) relY else event.getAxisValue(MotionEvent.AXIS_VSCROLL) * 40f
                val commands = hardwarePointer.onMove(useX, useY)
                if (commands.isNotEmpty()) {
                    sendSequence(commands, announce = false)
                    return true
                }
            }
            MotionEvent.ACTION_SCROLL -> {
                hardwarePointer.onScroll(event.getAxisValue(MotionEvent.AXIS_VSCROLL))?.let {
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

    override fun onDestroy() {
        ioExecutor.shutdownNow()
        super.onDestroy()
    }

    private enum class Mode { MOUSE, KEYBOARD, CLASSIC }
}
