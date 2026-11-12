package com.irremote.tv

import android.Manifest
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.text.InputFilter
import android.text.InputType
import android.view.InputDevice
import android.view.KeyEvent
import android.view.MotionEvent
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.EditText
import android.widget.GridLayout
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.button.MaterialButton
import com.irremote.tv.bluetooth.BluetoothHidRemote
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
import com.irremote.tv.net.ConnectOutcome
import com.irremote.tv.net.DiscoveredTv
import com.irremote.tv.net.PromptListener
import com.irremote.tv.net.SharedPrefsPairingStore
import com.irremote.tv.net.TvDiscovery
import com.irremote.tv.net.WifiRemoteManager
import com.irremote.tv.net.androidtv.ClientIdentity
import com.irremote.tv.ui.ButtonHaptics
import com.irremote.tv.wifi.WifiTvScanner
import java.io.File
import java.util.concurrent.Executors
import kotlin.math.roundToInt

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private lateinit var router: TvCommandRouter
    private lateinit var wifi: WifiRemoteManager
    private lateinit var bluetooth: BluetoothHidRemote
    private lateinit var runner: IrCommandRunner
    private var selectedBrand: TvBrand = TvBrand.HAIER
    private var warnedMissingIr = false
    private var lastScannedDevices: List<DiscoveredTv> = emptyList()
    private var promptDialog: AlertDialog? = null

    private val keyboardNavigator = TvKeyboardNavigator()
    private val hardwarePointer = PointerController(stepPixels = 36f, minIntervalMs = 70L)
    private val ioExecutor = Executors.newSingleThreadExecutor()
    private val netExecutor = Executors.newSingleThreadExecutor()
    private val mainHandler = Handler(Looper.getMainLooper())
    private val identity by lazy { ClientIdentity.loadOrCreate(File(filesDir, "atv_client.p12")) }

    private val btPermissionRequest = registerForActivityResult(
        ActivityResultContracts.RequestMultiplePermissions()
    ) { granted ->
        if (granted.values.all { it }) {
            bluetooth.start()
            refreshBluetoothDevices()
        } else {
            setBluetoothStatus(getString(R.string.bt_need_permission), connected = false)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val ir = AndroidIrTransmitter(this)
        wifi = WifiRemoteManager(SharedPrefsPairingStore(this), identity = { identity })
        bluetooth = BluetoothHidRemote(this)
        router = TvCommandRouter(ir, wifi, bluetooth.takeIf { it.isSupported })
        runner = IrCommandRunner(sender = { brand, command -> router.send(brand, command) })

        setupStatus()
        setupLinkToggle()
        setupWifiPanel()
        setupBluetoothPanel()
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

        // Optional automation:
        // adb shell am start -n com.irremote.tv/.MainActivity --es wifi_ip 10.0.2.2 --esa send_commands HOME,INPUT,MENU
        intent.getStringExtra(EXTRA_WIFI_IP)?.trim()?.takeIf { it.isNotEmpty() }?.let { ip ->
            binding.linkToggle.check(R.id.linkWifi)
            binding.wifiInclude.wifiIpInput.setText(ip)
            connectWifi(ip)
            val pending = intent.getStringArrayExtra(EXTRA_SEND_COMMANDS)
            if (!pending.isNullOrEmpty()) {
                scheduleAutomationCommands(pending)
            }
        }
    }

    private fun scheduleAutomationCommands(names: Array<String>) {
        ioExecutor.execute {
            // Wait for Wi‑Fi connect to finish
            var waits = 0
            while (!wifi.isReady && waits < 100) {
                Thread.sleep(150)
                waits++
            }
            if (!wifi.isReady) return@execute
            for (name in names) {
                val command = runCatching { RemoteCommand.valueOf(name.trim().uppercase()) }.getOrNull()
                    ?: continue
                val result = router.send(selectedBrand, command)
                mainHandler.post { showResult(command, result) }
                Thread.sleep(250)
            }
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
                val tv = wifi.connectedTv
                val label = if (tv != null && wifi.isReady) getString(R.string.wifi_connected_fmt, tv.displayLabel) else null
                val text = label ?: getString(R.string.wifi_not_connected)
                val color = getColor(if (label != null) R.color.accent_teal else R.color.accent_amber)
                binding.usbStatusText.text = text
                binding.usbStatusText.setTextColor(color)
                binding.wifiInclude.wifiStatusText.text = text
                binding.wifiInclude.wifiStatusText.setTextColor(color)
            }
            ControlLink.BLUETOOTH -> {
                binding.statusText.text = getString(R.string.status_bt_mode)
                binding.statusText.setTextColor(getColor(R.color.accent_teal))
                val name = bluetooth.connectedName
                if (name != null && bluetooth.isReady) {
                    binding.usbStatusText.text = getString(R.string.bt_connected_fmt, name)
                    binding.usbStatusText.setTextColor(getColor(R.color.accent_teal))
                } else {
                    binding.usbStatusText.text = getString(R.string.bt_not_connected)
                    binding.usbStatusText.setTextColor(getColor(R.color.accent_amber))
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
                R.id.linkBluetooth -> applyLink(ControlLink.BLUETOOTH)
            }
        }
    }

    private fun applyLink(link: ControlLink) {
        router.link = link
        binding.wifiInclude.root.visibility = if (link == ControlLink.WIFI) View.VISIBLE else View.GONE
        binding.bluetoothInclude.root.visibility = if (link == ControlLink.BLUETOOTH) View.VISIBLE else View.GONE
        // Brand IR codes only matter for IR
        val showBrand = link == ControlLink.IR
        binding.brandLabel.visibility = if (showBrand) View.VISIBLE else View.GONE
        binding.brandSpinner.visibility = if (showBrand) View.VISIBLE else View.GONE
        refreshStatusBanner()
        when (link) {
            ControlLink.IR -> if (!router.statusReady() && !warnedMissingIr) showMissingIrDialog()
            ControlLink.WIFI -> refreshLastTvButton()
            ControlLink.BLUETOOTH -> prepareBluetooth()
        }
    }

    // ---------------------------------------------------------------- Wi‑Fi

    private fun setupWifiPanel() {
        val panel = binding.wifiInclude
        panel.btnWifiConnect.setOnClickListener {
            ButtonHaptics.click(it)
            val typed = panel.wifiIpInput.text?.toString()?.trim().orEmpty()
            val scanned = lastScannedDevices.firstOrNull { d -> d.ip == typed }
                ?: lastScannedDevices.firstOrNull()?.takeIf { typed.isEmpty() }
            if (scanned != null) {
                panel.wifiIpInput.setText(scanned.ip)
                connectTv(scanned)
                return@setOnClickListener
            }
            if (typed.isEmpty()) {
                panel.wifiStatusText.text = getString(R.string.wifi_need_ip)
                panel.wifiStatusText.setTextColor(getColor(R.color.accent_amber))
                return@setOnClickListener
            }
            connectWifi(typed)
        }
        panel.btnWifiScan.setOnClickListener {
            ButtonHaptics.click(it)
            scanWifi()
        }
        panel.btnWifiLast.setOnClickListener {
            ButtonHaptics.click(it)
            wifi.lastTv()?.let { tv ->
                panel.wifiIpInput.setText(tv.ip)
                connectTv(tv)
            }
        }
        refreshLastTvButton()
    }

    private fun refreshLastTvButton() {
        val button = binding.wifiInclude.btnWifiLast
        val last = wifi.lastTv()
        if (last == null || (wifi.isReady && wifi.connectedTv?.ip == last.ip)) {
            button.visibility = View.GONE
        } else {
            button.text = getString(R.string.wifi_last_tv_fmt, last.displayLabel)
            button.visibility = View.VISIBLE
        }
    }

    private fun scanWifi() {
        val panel = binding.wifiInclude
        panel.wifiScanResultText.text = getString(R.string.wifi_scanning)
        panel.wifiDeviceList.removeAllViews()
        panel.btnWifiScan.isEnabled = false
        netExecutor.execute {
            val devices = try {
                val prefix = WifiTvScanner(this).localSubnetPrefix()
                if (prefix == null) emptyList() else TvDiscovery(wifi).scanSubnet(prefix)
            } catch (_: Exception) {
                emptyList()
            }
            mainHandler.post {
                lastScannedDevices = devices
                panel.btnWifiScan.isEnabled = true
                panel.wifiDeviceList.removeAllViews()
                if (devices.isEmpty()) {
                    panel.wifiScanResultText.text = getString(R.string.wifi_scan_none)
                } else {
                    panel.wifiScanResultText.text = getString(R.string.wifi_scan_found, devices.size)
                    devices.forEach { device -> addWifiDeviceRow(device) }
                    if (devices.size == 1 && !wifi.isReady) {
                        panel.wifiIpInput.setText(devices[0].ip)
                        connectTv(devices[0])
                    }
                }
            }
        }
    }

    private fun addWifiDeviceRow(device: DiscoveredTv) {
        val button = MaterialButton(this, null, com.google.android.material.R.attr.materialButtonOutlinedStyle).apply {
            text = device.displayLabel
            isAllCaps = false
            setOnClickListener {
                ButtonHaptics.click(it)
                binding.wifiInclude.wifiIpInput.setText(device.ip)
                connectTv(device)
            }
        }
        binding.wifiInclude.wifiDeviceList.addView(button)
    }

    private val tvPrompt = PromptListener { message ->
        mainHandler.post {
            binding.wifiInclude.wifiStatusText.text = message
            binding.wifiInclude.wifiStatusText.setTextColor(getColor(R.color.accent_amber))
            promptDialog?.dismiss()
            promptDialog = AlertDialog.Builder(this)
                .setTitle(R.string.wifi_prompt_title)
                .setMessage(message)
                .setPositiveButton(android.R.string.ok, null)
                .show()
        }
    }

    private fun connectWifi(ip: String) = startConnect { wifi.connectIp(ip, tvPrompt) }

    private fun connectTv(tv: DiscoveredTv) = startConnect { wifi.connect(tv, tvPrompt) }

    private fun startConnect(block: () -> ConnectOutcome) {
        binding.wifiInclude.wifiStatusText.text = getString(R.string.wifi_connecting)
        binding.wifiInclude.wifiStatusText.setTextColor(getColor(R.color.accent_amber))
        binding.wifiInclude.btnWifiConnect.isEnabled = false
        netExecutor.execute {
            val outcome = block()
            mainHandler.post { handleOutcome(outcome) }
        }
    }

    private fun handleOutcome(outcome: ConnectOutcome) {
        promptDialog?.dismiss()
        promptDialog = null
        binding.wifiInclude.btnWifiConnect.isEnabled = true
        when (outcome) {
            is ConnectOutcome.Connected -> {
                Toast.makeText(
                    this,
                    getString(R.string.wifi_connected_fmt, outcome.session.tv.displayLabel),
                    Toast.LENGTH_SHORT
                ).show()
                refreshStatusBanner()
                refreshLastTvButton()
            }
            is ConnectOutcome.NeedsPin -> showPinDialog(outcome)
            is ConnectOutcome.Failed -> {
                Toast.makeText(this, outcome.reason, Toast.LENGTH_LONG).show()
                refreshStatusBanner()
                binding.wifiInclude.wifiStatusText.text = getString(R.string.wifi_connect_failed_fmt, outcome.reason)
                binding.wifiInclude.wifiStatusText.setTextColor(getColor(R.color.accent_red))
            }
        }
    }

    private fun showPinDialog(request: ConnectOutcome.NeedsPin) {
        binding.wifiInclude.wifiStatusText.text = getString(R.string.wifi_pin_title)
        binding.wifiInclude.wifiStatusText.setTextColor(getColor(R.color.accent_amber))
        val input = EditText(this).apply {
            hint = getString(R.string.wifi_pin_hint)
            inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_FLAG_CAP_CHARACTERS or
                InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS
            filters = arrayOf(InputFilter.LengthFilter(6), InputFilter.AllCaps())
            textSize = 22f
            setPadding(48, 32, 48, 32)
        }
        val message = buildString {
            request.error?.let { append(it).append("\n\n") }
            append(getString(R.string.wifi_pin_message, request.tv.name))
        }
        AlertDialog.Builder(this)
            .setTitle(R.string.wifi_pin_title)
            .setMessage(message)
            .setView(input)
            .setCancelable(false)
            .setPositiveButton(R.string.wifi_pin_pair) { _, _ ->
                val pin = input.text?.toString().orEmpty()
                binding.wifiInclude.wifiStatusText.text = getString(R.string.wifi_pairing)
                netExecutor.execute {
                    val outcome = request.submit(pin)
                    mainHandler.post { handleOutcome(outcome) }
                }
            }
            .setNegativeButton(android.R.string.cancel) { _, _ ->
                netExecutor.execute { request.cancel() }
                refreshStatusBanner()
            }
            .show()
    }

    // ------------------------------------------------------------ Bluetooth

    private fun setupBluetoothPanel() {
        val panel = binding.bluetoothInclude
        bluetooth.listener = object : BluetoothHidRemote.Listener {
            override fun onBluetoothState(message: String, connected: Boolean) {
                mainHandler.post {
                    setBluetoothStatus(message, connected)
                    refreshStatusBanner()
                }
            }
        }
        panel.btnBtDiscoverable.setOnClickListener {
            ButtonHaptics.click(it)
            if (!prepareBluetooth()) return@setOnClickListener
            try {
                startActivity(
                    Intent(BluetoothAdapter.ACTION_REQUEST_DISCOVERABLE)
                        .putExtra(BluetoothAdapter.EXTRA_DISCOVERABLE_DURATION, 180)
                )
            } catch (error: Exception) {
                Toast.makeText(this, error.message ?: "Bluetooth unavailable", Toast.LENGTH_LONG).show()
            }
        }
        panel.btnBtRefresh.setOnClickListener {
            ButtonHaptics.click(it)
            if (prepareBluetooth()) refreshBluetoothDevices()
        }
    }

    /** Checks support, permission and adapter state; starts the HID service when possible. */
    private fun prepareBluetooth(): Boolean {
        if (!bluetooth.isSupported) {
            setBluetoothStatus(getString(R.string.bt_unsupported), connected = false)
            return false
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            val needed = arrayOf(Manifest.permission.BLUETOOTH_CONNECT, Manifest.permission.BLUETOOTH_ADVERTISE)
            if (needed.any { checkSelfPermission(it) != PackageManager.PERMISSION_GRANTED }) {
                btPermissionRequest.launch(needed)
                return false
            }
        }
        if (!bluetooth.isEnabled) {
            setBluetoothStatus(getString(R.string.bt_turn_on), connected = false)
            runCatching { startActivity(Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)) }
            return false
        }
        bluetooth.start()
        if (binding.bluetoothInclude.btDeviceList.childCount == 0) refreshBluetoothDevices()
        return true
    }

    private fun refreshBluetoothDevices() {
        val list = binding.bluetoothInclude.btDeviceList
        list.removeAllViews()
        val devices = bluetooth.bondedDevices()
        if (devices.isEmpty()) {
            setBluetoothStatus(getString(R.string.bt_none_paired), connected = bluetooth.isReady)
            return
        }
        devices.forEach { device -> addBluetoothRow(device) }
    }

    private fun addBluetoothRow(device: BluetoothDevice) {
        val button = MaterialButton(this, null, com.google.android.material.R.attr.materialButtonOutlinedStyle).apply {
            text = bluetooth.deviceName(device)
            isAllCaps = false
            setOnClickListener {
                ButtonHaptics.click(it)
                bluetooth.connect(device)
            }
        }
        binding.bluetoothInclude.btDeviceList.addView(button)
    }

    private fun setBluetoothStatus(message: String, connected: Boolean) {
        binding.bluetoothInclude.btStatusText.text = message
        binding.bluetoothInclude.btStatusText.setTextColor(
            getColor(if (connected) R.color.accent_teal else R.color.accent_amber)
        )
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
            binding.btnInput to RemoteCommand.INPUT,
            binding.btnVolUp to RemoteCommand.VOL_UP,
            binding.btnVolDown to RemoteCommand.VOL_DOWN,
            binding.btnChUp to RemoteCommand.CH_UP,
            binding.btnChDown to RemoteCommand.CH_DOWN
        ).forEach { (button, command) ->
            button.setOnClickListener { sendSingle(it, command) }
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
            button.setOnClickListener { sendSingle(it, command) }
        }
    }

    private fun setupTouchpad() {
        val pad = binding.touchpadInclude
        pad.touchpadView.listener = object : TouchpadView.Listener {
            override fun onIrCommands(commands: List<RemoteCommand>) {
                if (commands.isNotEmpty()) ButtonHaptics.vibrate(this@MainActivity)
                sendSequence(commands, announce = false)
            }

            override fun onStatus(message: String) {
                binding.lastCommandText.text = message
                binding.lastCommandText.setTextColor(getColor(R.color.accent_teal))
            }

            override fun onPointerDelta(dx: Float, dy: Float): Boolean {
                if (router.link != ControlLink.BLUETOOTH || !bluetooth.isReady) return false
                bluetooth.moveMouse((dx * MOUSE_GAIN).roundToInt(), (dy * MOUSE_GAIN).roundToInt())
                return true
            }

            override fun onTap(): Boolean {
                if (router.link != ControlLink.BLUETOOTH || !bluetooth.isReady) return false
                ButtonHaptics.vibrate(this@MainActivity)
                bluetooth.click()
                binding.lastCommandText.text = getString(R.string.last_command, "Click (Bluetooth)")
                return true
            }
        }
        pad.btnPadOk.setOnClickListener { sendSingle(it, RemoteCommand.OK) }
        pad.btnPadBack.setOnClickListener { sendSingle(it, RemoteCommand.BACK) }
        pad.btnPadHome.setOnClickListener { sendSingle(it, RemoteCommand.HOME) }
    }

    private fun setupKeyboard() {
        val kb = binding.keyboardInclude
        kb.btnResetKeyboardCursor.setOnClickListener {
            ButtonHaptics.click(it)
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
                    setOnClickListener {
                        ButtonHaptics.click(it)
                        onSoftKey(ch)
                    }
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
            setOnClickListener {
                ButtonHaptics.click(it)
                onClick()
            }
        }
        grid.addView(button)
    }

    private fun onSoftKey(ch: Char) {
        if (!ensureTransport()) return
        if (router.supportsText()) {
            val text = when (ch) {
                '↵' -> "\n"
                else -> ch.toString()
            }
            ioExecutor.execute {
                val result = router.sendText(text)
                mainHandler.post {
                    if (result is TransmitResult.Failed) {
                        binding.lastCommandText.text = result.reason
                        binding.lastCommandText.setTextColor(Color.parseColor("#F87171"))
                    } else {
                        val shown = when (ch) {
                            '\b' -> "⌫"
                            '↵' -> "Enter"
                            ' ' -> "Space"
                            else -> ch.toString()
                        }
                        binding.lastCommandText.text = "${getString(R.string.typing_direct)} → $shown"
                        binding.lastCommandText.setTextColor(getColor(R.color.accent_teal))
                    }
                }
            }
            return
        }
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

    private fun sendSingle(view: View?, command: RemoteCommand) {
        if (view != null) ButtonHaptics.click(view) else ButtonHaptics.vibrate(this)
        sendSingle(command)
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
                val via = when (router.link) {
                    ControlLink.IR -> "IR"
                    ControlLink.WIFI -> wifi.connectedTv?.protocol?.displayName ?: "Wi‑Fi"
                    ControlLink.BLUETOOTH -> "Bluetooth"
                }
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
            ControlLink.BLUETOOTH -> {
                Toast.makeText(
                    this,
                    if (bluetooth.isSupported) R.string.need_bt_connect else R.string.bt_unsupported,
                    Toast.LENGTH_LONG
                ).show()
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
                    "\n\nOr switch to Wi‑Fi or Bluetooth mode to control your TV without IR."
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
        promptDialog?.dismiss()
        bluetooth.stop()
        ioExecutor.shutdownNow()
        netExecutor.execute { wifi.disconnect() }
        netExecutor.shutdown()
        super.onDestroy()
    }

    private enum class Mode { MOUSE, KEYBOARD, CLASSIC }

    companion object {
        private const val MOUSE_GAIN = 1.4f
        const val EXTRA_WIFI_IP = "wifi_ip"
        const val EXTRA_SEND_COMMANDS = "send_commands"
    }
}
