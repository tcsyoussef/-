package com.irremote.tv

import android.Manifest
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.content.pm.PackageManager
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.text.Editable
import android.text.InputFilter
import android.text.InputType
import android.text.TextWatcher
import android.view.Gravity
import android.view.InputDevice
import android.view.KeyEvent
import android.view.LayoutInflater
import android.view.MotionEvent
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.EditorInfo
import android.widget.EditText
import android.widget.FrameLayout
import android.widget.GridLayout
import android.widget.LinearLayout
import android.widget.TextView
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.button.MaterialButton
import com.google.android.material.chip.Chip
import com.google.android.material.dialog.MaterialAlertDialogBuilder
import com.google.android.material.snackbar.Snackbar
import com.irremote.tv.bluetooth.BluetoothHidRemote
import com.irremote.tv.control.ControlLink
import com.irremote.tv.control.TvApp
import com.irremote.tv.control.TvCommandRouter
import com.irremote.tv.databinding.ActivityMainBinding
import com.irremote.tv.databinding.ItemDeviceBinding
import com.irremote.tv.databinding.SheetConnectBinding
import com.irremote.tv.input.PointerController
import com.irremote.tv.input.TouchpadView
import com.irremote.tv.input.TvKeyboardNavigator
import com.irremote.tv.input.VoiceController
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
import com.irremote.tv.ui.SegmentedTabs
import com.irremote.tv.wifi.WifiTvScanner
import java.io.File
import java.util.concurrent.Executors
import kotlin.math.roundToInt

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private lateinit var router: TvCommandRouter
    private lateinit var wifi: WifiRemoteManager
    private lateinit var bluetooth: BluetoothHidRemote
    private lateinit var ir: AndroidIrTransmitter
    private lateinit var prefs: SharedPreferences

    /** The connection the user chose; null = disconnected. */
    private var activeLink: ControlLink? = null
    private var connecting: String? = null
    private var selectedBrand: TvBrand = TvBrand.HAIER

    private var sheet: BottomSheetDialog? = null
    private var sheetBinding: SheetConnectBinding? = null
    private var promptDialog: AlertDialog? = null
    private var scanning = false
    private var foundTvs: List<DiscoveredTv> = emptyList()
    private var pendingWifiRow: ItemDeviceBinding? = null
    private var btConnecting = false

    private val keyboardNavigator = TvKeyboardNavigator()
    private val hardwarePointer = PointerController(stepPixels = 36f, minIntervalMs = 70L)
    private var gridTypingBusy = false
    private var suppressTypeWatcher = false
    private var lastTyped = ""

    private val ioExecutor = Executors.newSingleThreadExecutor()
    private val netExecutor = Executors.newSingleThreadExecutor()
    private val scanExecutor = Executors.newSingleThreadExecutor()
    private val mainHandler = Handler(Looper.getMainLooper())
    private val identity by lazy { ClientIdentity.loadOrCreate(File(filesDir, "atv_client.p12")) }

    private val btPermissionRequest = registerForActivityResult(
        ActivityResultContracts.RequestMultiplePermissions()
    ) { granted ->
        if (granted.values.all { it }) {
            bluetooth.start()
            renderBluetoothDevices()
        } else {
            setSheetStatus(getString(R.string.bt_need_permission), error = true)
        }
    }

    private val micPermissionRequest = registerForActivityResult(
        ActivityResultContracts.RequestPermission()
    ) { granted ->
        if (granted) startVoiceSession()
        else snack(getString(R.string.voice_need_mic))
    }

    private lateinit var voice: VoiceController
    private var voiceStreaming = false
    private var voiceLevelAnimator: android.animation.ValueAnimator? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        prefs = getSharedPreferences("ui", Context.MODE_PRIVATE)
        ir = AndroidIrTransmitter(this)
        wifi = WifiRemoteManager(SharedPrefsPairingStore(this), identity = { identity })
        bluetooth = BluetoothHidRemote(this)
        router = TvCommandRouter(ir, wifi, bluetooth.takeIf { it.isSupported })
        selectedBrand = runCatching { TvBrand.valueOf(prefs.getString(PREF_BRAND, null) ?: "") }
            .getOrDefault(TvBrand.HAIER)

        bluetooth.listener = object : BluetoothHidRemote.Listener {
            override fun onBluetoothState(message: String, connected: Boolean) {
                mainHandler.post { onBluetoothState(message, connected) }
            }
        }

        binding.btnConnection.setOnClickListener {
            ButtonHaptics.click(it)
            if (activeLink != null || connecting != null) disconnect() else openConnectSheet()
        }
        binding.statusArea.setOnClickListener {
            ButtonHaptics.click(it)
            openConnectSheet()
        }
        setupPages()
        bindRemoteKeys()
        setupTouchpad()
        setupKeyboard()
        setupVoice()
        updateHeader()
        runCatching {
            getSystemService(ConnectivityManager::class.java).registerNetworkCallback(
                NetworkRequest.Builder().addTransportType(NetworkCapabilities.TRANSPORT_WIFI).build(),
                wifiCallback
            )
        }

        val automationIp = intent.getStringExtra(EXTRA_WIFI_IP)?.trim()?.takeIf { it.isNotEmpty() }
        if (automationIp != null) {
            connectWifi(automationIp, null)
            intent.getStringArrayExtra(EXTRA_SEND_COMMANDS)?.takeIf { it.isNotEmpty() }
                ?.let { scheduleAutomationCommands(it) }
        } else {
            restoreLastConnection()
        }
    }

    // ------------------------------------------------------------ connection state

    private fun restoreLastConnection() {
        when (prefs.getString(PREF_LINK, null)) {
            ControlLink.WIFI.name -> if (wifi.lastTv() != null) reconnectWifi() else openConnectSheet()
            ControlLink.IR.name -> if (ir.hasBuiltInEmitter) activate(ControlLink.IR) else openConnectSheet()
            ControlLink.BLUETOOTH.name -> {
                if (bluetooth.isSupported && bluetooth.hasPermission() && bluetooth.isEnabled) {
                    val address = prefs.getString(PREF_BT, null)
                    val device = bluetooth.bondedDevices().firstOrNull { it.address == address }
                    if (device != null) {
                        connecting = bluetooth.deviceName(device)
                        btConnecting = true
                        bluetooth.connect(device)
                        updateHeader()
                    } else {
                        bluetooth.start()
                    }
                }
            }
            else -> mainHandler.postDelayed({ if (activeLink == null) openConnectSheet() }, 350)
        }
    }

    private fun activate(link: ControlLink) {
        activeLink = link
        connecting = null
        router.link = link
        prefs.edit().putString(PREF_LINK, link.name).apply()
        updateHeader()
        updateKeyboardMode()
    }

    private fun disconnect() {
        when (activeLink) {
            ControlLink.WIFI -> netExecutor.execute { wifi.disconnect() }
            ControlLink.BLUETOOTH -> bluetooth.disconnect()
            else -> Unit
        }
        if (btConnecting) bluetooth.disconnect()
        btConnecting = false
        if (connecting != null && activeLink == null) netExecutor.execute { wifi.disconnect() }
        activeLink = null
        connecting = null
        prefs.edit().remove(PREF_LINK).apply()
        updateHeader()
        updateKeyboardMode()
        snack(getString(R.string.disconnected))
    }

    private fun isConnected(): Boolean = when (activeLink) {
        null -> false
        ControlLink.IR -> ir.hasBuiltInEmitter
        ControlLink.WIFI -> wifi.isReady
        ControlLink.BLUETOOTH -> bluetooth.isReady
    }

    private fun updateHeader() {
        val link = activeLink
        val (dotColor, label, name) = when {
            connecting != null -> Triple(R.color.warning, getString(R.string.status_connecting), connecting!!)
            link == ControlLink.WIFI && wifi.isReady -> {
                val tv = wifi.connectedTv!!
                Triple(R.color.success, getString(R.string.status_wifi_fmt, tv.protocol.displayName), tv.name)
            }
            link == ControlLink.BLUETOOTH && bluetooth.isReady ->
                Triple(R.color.success, getString(R.string.status_bluetooth), bluetooth.connectedName ?: "TV")
            link == ControlLink.IR ->
                Triple(R.color.success, getString(R.string.status_ir_fmt, selectedBrand.displayName), getString(R.string.ir_tv_name))
            link != null -> Triple(R.color.warning, getString(R.string.status_not_connected), getString(R.string.no_tv))
            else -> Triple(R.color.text_faint, getString(R.string.status_not_connected), getString(R.string.no_tv))
        }
        binding.statusDot.setColorFilter(getColor(dotColor))
        binding.statusLabel.text = label
        binding.tvName.text = name

        val showDisconnect = link != null || connecting != null
        binding.btnConnection.apply {
            text = getString(if (showDisconnect) R.string.disconnect else R.string.connect)
            setIconResource(if (showDisconnect) R.drawable.ic_close else R.drawable.ic_link)
            if (showDisconnect) {
                setBackgroundResource(0)
                backgroundTintList = getColorStateList(R.color.surface_high)
                setTextColor(getColor(R.color.text_primary))
                iconTint = getColorStateList(R.color.text_primary)
            } else {
                setBackgroundResource(R.drawable.bg_gradient_pill)
                backgroundTintList = null
                setTextColor(getColor(R.color.on_accent))
                iconTint = getColorStateList(R.color.on_accent)
            }
        }
    }

    // ------------------------------------------------------------ connect sheet

    private fun openConnectSheet(tab: ControlLink? = null) {
        if (sheet?.isShowing == true) return
        val sb = SheetConnectBinding.inflate(layoutInflater)
        val dialog = BottomSheetDialog(this)
        dialog.setContentView(sb.root)
        dialog.behavior.state = BottomSheetBehavior.STATE_EXPANDED
        dialog.behavior.skipCollapsed = true
        dialog.setOnDismissListener {
            if (sheet === dialog) {
                sheet = null
                sheetBinding = null
                pendingWifiRow = null
            }
        }
        sheet = dialog
        sheetBinding = sb

        val sheetTabs = SegmentedTabs(listOf(sb.sheetTabWifi, sb.sheetTabBt, sb.sheetTabIr)) { id ->
            ButtonHaptics.vibrate(this)
            showSheetSection(
                when (id) {
                    R.id.sheetTabBt -> ControlLink.BLUETOOTH
                    R.id.sheetTabIr -> ControlLink.IR
                    else -> ControlLink.WIFI
                }
            )
        }
        sb.btnSearchAgain.setOnClickListener { ButtonHaptics.click(it); startScan() }
        sb.btnShowIp.setOnClickListener {
            sb.ipGroup.visibility = View.VISIBLE
            sb.btnShowIp.visibility = View.GONE
            sb.ipInput.requestFocus()
        }
        val connectTyped = {
            val ip = sb.ipInput.text?.toString()?.trim().orEmpty()
            if (ip.isEmpty()) setSheetStatus(getString(R.string.wifi_need_ip), error = true)
            else connectWifi(ip, null)
        }
        sb.btnIpConnect.setOnClickListener { ButtonHaptics.click(it); connectTyped() }
        sb.ipInput.setOnEditorActionListener { _, _, _ -> connectTyped(); true }
        sb.btnBtVisible.setOnClickListener { ButtonHaptics.click(it); makeBluetoothVisible() }
        setupIrSection(sb)

        val initial = tab ?: activeLink ?: runCatching {
            ControlLink.valueOf(prefs.getString(PREF_LINK, null) ?: "")
        }.getOrDefault(ControlLink.WIFI)
        dialog.show()
        sheetTabs.check(
            when (initial) {
                ControlLink.BLUETOOTH -> R.id.sheetTabBt
                ControlLink.IR -> R.id.sheetTabIr
                ControlLink.WIFI -> R.id.sheetTabWifi
            }
        )
    }

    private fun showSheetSection(link: ControlLink) {
        val sb = sheetBinding ?: return
        sb.wifiSection.visibility = if (link == ControlLink.WIFI) View.VISIBLE else View.GONE
        sb.btSection.visibility = if (link == ControlLink.BLUETOOTH) View.VISIBLE else View.GONE
        sb.irSection.visibility = if (link == ControlLink.IR) View.VISIBLE else View.GONE
        sb.sheetStatus.visibility = View.GONE
        when (link) {
            ControlLink.WIFI -> {
                renderWifiDevices()
                if (!scanning && foundTvs.isEmpty()) startScan()
            }
            ControlLink.BLUETOOTH -> if (prepareBluetooth()) renderBluetoothDevices()
            ControlLink.IR -> Unit
        }
    }

    private fun setSheetStatus(message: String?, error: Boolean = false) {
        val sb = sheetBinding ?: return
        if (message.isNullOrBlank()) {
            sb.sheetStatus.visibility = View.GONE
            return
        }
        sb.sheetStatus.text = message
        sb.sheetStatus.setTextColor(getColor(if (error) R.color.power else R.color.warning))
        sb.sheetStatus.visibility = View.VISIBLE
    }

    private fun addDeviceRow(
        container: LinearLayout,
        name: String,
        subtitle: String,
        iconRes: Int,
        onClick: (ItemDeviceBinding) -> Unit
    ): ItemDeviceBinding {
        val row = ItemDeviceBinding.inflate(LayoutInflater.from(this), container, false)
        row.deviceName.text = name
        row.deviceSubtitle.text = subtitle
        row.deviceIcon.setImageResource(iconRes)
        row.root.setOnClickListener {
            ButtonHaptics.click(it)
            onClick(row)
        }
        container.addView(row.root)
        return row
    }

    private fun setRowBusy(row: ItemDeviceBinding?, busy: Boolean) {
        row ?: return
        row.deviceProgress.visibility = if (busy) View.VISIBLE else View.GONE
        row.deviceChevron.visibility = if (busy) View.GONE else View.VISIBLE
    }

    // ------------------------------------------------------------ Wi‑Fi

    private fun startScan() {
        val sb = sheetBinding ?: return
        if (scanning) return
        scanning = true
        sb.searchingRow.visibility = View.VISIBLE
        sb.wifiEmpty.visibility = View.GONE
        sb.btnSearchAgain.isEnabled = false
        scanExecutor.execute {
            val devices = scanLocalTvs()
            mainHandler.post {
                scanning = false
                foundTvs = devices
                val s = sheetBinding ?: return@post
                s.searchingRow.visibility = View.GONE
                s.btnSearchAgain.isEnabled = true
                renderWifiDevices()
                if (devices.isEmpty() && wifi.lastTv() == null) s.wifiEmpty.visibility = View.VISIBLE
                // Only one TV on the network: connect to it without asking
                val only = devices.singleOrNull()
                if (only != null && s.wifiSection.visibility == View.VISIBLE &&
                    activeLink != ControlLink.WIFI && connecting == null
                ) {
                    connectTv(only, null)
                }
            }
        }
    }

    private fun renderWifiDevices() {
        val sb = sheetBinding ?: return
        sb.wifiDeviceList.removeAllViews()
        val last = wifi.lastTv()
        val list = ArrayList<DiscoveredTv>()
        if (last != null) list += foundTvs.firstOrNull { it.ip == last.ip } ?: last
        list += foundTvs.filter { it.ip != last?.ip }
        for (tv in list) {
            val subtitle = buildString {
                append(tv.protocol.displayName)
                if (tv.ip == last?.ip) append(" · ").append(getString(R.string.wifi_last_used))
            }
            addDeviceRow(sb.wifiDeviceList, tv.name, subtitle, R.drawable.ic_tv) { row ->
                pendingWifiRow = row
                connectTv(tv, row)
            }
        }
    }

    private val tvPrompt = PromptListener { message ->
        mainHandler.post {
            setSheetStatus(message)
            promptDialog?.dismiss()
            promptDialog = MaterialAlertDialogBuilder(this)
                .setTitle(R.string.prompt_title)
                .setMessage(message)
                .setPositiveButton(R.string.ok, null)
                .show()
        }
    }

    /** Reconnects to the saved TV, finding it again if the router gave it a new IP. */
    private fun reconnectWifi() {
        val last = wifi.lastTv() ?: return
        startConnect(last.name, null) { wifi.connectSaved(tvPrompt) { scanLocalTvs() } }
    }

    private fun scanLocalTvs(): List<DiscoveredTv> = try {
        val prefix = WifiTvScanner(this).localSubnetPrefix()
        if (prefix == null) emptyList() else TvDiscovery(wifi).scanSubnet(prefix)
    } catch (_: Exception) {
        emptyList()
    }

    private fun connectWifi(ip: String, row: ItemDeviceBinding?) =
        startConnect(ip, row) { wifi.connectIp(ip, tvPrompt) }

    private fun connectTv(tv: DiscoveredTv, row: ItemDeviceBinding?) =
        startConnect(tv.name, row) { wifi.connect(tv, tvPrompt) }

    private fun startConnect(label: String, row: ItemDeviceBinding?, block: () -> ConnectOutcome) {
        connecting = label
        if (activeLink == ControlLink.WIFI) activeLink = null
        updateHeader()
        setRowBusy(row, true)
        setSheetStatus(getString(R.string.connecting_fmt, label))
        netExecutor.execute {
            val outcome = block()
            mainHandler.post { handleOutcome(outcome, row) }
        }
    }

    private fun handleOutcome(outcome: ConnectOutcome, row: ItemDeviceBinding?) {
        promptDialog?.dismiss()
        promptDialog = null
        setRowBusy(row, false)
        when (outcome) {
            is ConnectOutcome.Connected -> {
                activate(ControlLink.WIFI)
                sheet?.dismiss()
                snack(getString(R.string.connected_fmt, outcome.session.tv.name))
            }
            is ConnectOutcome.NeedsPin -> showPinDialog(outcome, row)
            is ConnectOutcome.Failed -> {
                val label = connecting
                connecting = null
                updateHeader()
                if (sheet?.isShowing == true) {
                    setSheetStatus(outcome.reason, error = true)
                } else {
                    snack(
                        if (label != null) getString(R.string.reconnect_failed_fmt, label) else outcome.reason,
                        actionLabel = getString(R.string.connect)
                    ) { openConnectSheet(ControlLink.WIFI) }
                }
            }
        }
    }

    private fun showPinDialog(request: ConnectOutcome.NeedsPin, row: ItemDeviceBinding?) {
        setSheetStatus(getString(R.string.pin_title))
        val input = EditText(this).apply {
            hint = getString(R.string.pin_hint)
            inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_FLAG_CAP_CHARACTERS or
                InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD
            filters = arrayOf(InputFilter.LengthFilter(6), InputFilter.AllCaps())
            textSize = 28f
            letterSpacing = 0.3f
            gravity = Gravity.CENTER
            setTextColor(getColor(R.color.text_primary))
            setHintTextColor(getColor(R.color.text_faint))
            background = getDrawable(R.drawable.bg_input_field)
            minHeight = dp(64)
        }
        val container = FrameLayout(this).apply {
            setPadding(dp(24), dp(8), dp(24), 0)
            addView(input, FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT))
        }
        val message = listOfNotNull(request.error, getString(R.string.pin_message)).joinToString("\n\n")
        val dialog = MaterialAlertDialogBuilder(this)
            .setTitle(R.string.pin_title)
            .setMessage(message)
            .setView(container)
            .setCancelable(false)
            .setPositiveButton(R.string.pin_pair) { _, _ ->
                val pin = input.text?.toString().orEmpty()
                setRowBusy(row, true)
                setSheetStatus(getString(R.string.pairing))
                netExecutor.execute {
                    val outcome = request.submit(pin)
                    mainHandler.post { handleOutcome(outcome, row) }
                }
            }
            .setNegativeButton(R.string.cancel) { _, _ ->
                netExecutor.execute { request.cancel() }
                connecting = null
                updateHeader()
                setSheetStatus(null)
            }
            .show()
        input.requestFocus()
        dialog.window?.setSoftInputMode(android.view.WindowManager.LayoutParams.SOFT_INPUT_STATE_VISIBLE)
    }

    // ------------------------------------------------------------ Bluetooth

    private fun prepareBluetooth(): Boolean {
        if (!bluetooth.isSupported) {
            setSheetStatus(getString(R.string.bt_unsupported), error = true)
            sheetBinding?.btnBtVisible?.isEnabled = false
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
            setSheetStatus(getString(R.string.bt_turn_on), error = true)
            runCatching { startActivity(Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)) }
            return false
        }
        bluetooth.start()
        return true
    }

    private fun renderBluetoothDevices() {
        val sb = sheetBinding ?: return
        sb.btDeviceList.removeAllViews()
        val devices = bluetooth.bondedDevices()
        sb.btEmpty.visibility = if (devices.isEmpty()) View.VISIBLE else View.GONE
        devices.forEach { device -> addBluetoothRow(sb, device) }
    }

    private fun addBluetoothRow(sb: SheetConnectBinding, device: BluetoothDevice) {
        val connectedHere = bluetooth.isReady && bluetooth.connectedName == bluetooth.deviceName(device)
        addDeviceRow(
            sb.btDeviceList,
            bluetooth.deviceName(device),
            getString(if (connectedHere) R.string.bt_connected else R.string.bt_paired),
            R.drawable.ic_bluetooth
        ) { row ->
            setRowBusy(row, true)
            btConnecting = true
            connecting = bluetooth.deviceName(device)
            prefs.edit().putString(PREF_BT, device.address).apply()
            updateHeader()
            bluetooth.connect(device)
            mainHandler.postDelayed({ setRowBusy(row, false) }, 8000)
        }
    }

    private fun makeBluetoothVisible() {
        if (!prepareBluetooth()) return
        setSheetStatus(getString(R.string.bt_ready))
        runCatching {
            startActivity(
                Intent(BluetoothAdapter.ACTION_REQUEST_DISCOVERABLE)
                    .putExtra(BluetoothAdapter.EXTRA_DISCOVERABLE_DURATION, 180)
            )
        }
    }

    private fun onBluetoothState(message: String, connected: Boolean) {
        if (connected) {
            btConnecting = false
            activate(ControlLink.BLUETOOTH)
            sheet?.dismiss()
            snack(message)
            return
        }
        val stillConnecting = btConnecting && message.startsWith("Connecting")
        if (!stillConnecting) {
            if (activeLink == ControlLink.BLUETOOTH) activeLink = null
            if (btConnecting) connecting = null
            btConnecting = false
            updateHeader()
        }
        setSheetStatus(message)
        if (sheetBinding?.btSection?.visibility == View.VISIBLE) renderBluetoothDevices()
    }

    // ------------------------------------------------------------ Infrared

    private fun setupIrSection(sb: SheetConnectBinding) {
        if (!ir.hasBuiltInEmitter) {
            sb.irText.text = getString(R.string.ir_missing)
            sb.irBrandLabel.visibility = View.GONE
            sb.irBrandGroup.visibility = View.GONE
            sb.btnUseIr.visibility = View.GONE
            return
        }
        val brands = resources.getStringArray(R.array.tv_brands)
        brands.forEach { name ->
            val brand = TvBrand.fromDisplayName(name)
            val chip = Chip(this).apply {
                text = name
                isCheckable = true
                isChecked = brand == selectedBrand
                id = View.generateViewId()
                tag = brand
                chipBackgroundColor = getColorStateList(R.color.tab_bg_chip)
                setTextColor(getColorStateList(R.color.tab_fg))
                chipStrokeWidth = 0f
                isCheckedIconVisible = false
            }
            sb.irBrandGroup.addView(chip)
        }
        sb.btnUseIr.setOnClickListener {
            ButtonHaptics.click(it)
            val chip = sb.irBrandGroup.findViewById<Chip>(sb.irBrandGroup.checkedChipId)
            selectedBrand = (chip?.tag as? TvBrand) ?: selectedBrand
            prefs.edit().putString(PREF_BRAND, selectedBrand.name).apply()
            if (activeLink == ControlLink.WIFI) netExecutor.execute { wifi.disconnect() }
            activate(ControlLink.IR)
            sheet?.dismiss()
        }
    }

    // ------------------------------------------------------------ pages

    private fun setupPages() {
        val tabs = listOf(binding.tabRemote, binding.tabTouchpad, binding.tabKeyboard, binding.tabNumbers)
        SegmentedTabs(tabs) { id ->
            ButtonHaptics.vibrate(this)
            binding.pageRemote.visibility = if (id == R.id.tabRemote) View.VISIBLE else View.GONE
            binding.pageTouchpad.visibility = if (id == R.id.tabTouchpad) View.VISIBLE else View.GONE
            binding.pageKeyboard.visibility = if (id == R.id.tabKeyboard) View.VISIBLE else View.GONE
            binding.pageNumbers.visibility = if (id == R.id.tabNumbers) View.VISIBLE else View.GONE
            if (id == R.id.tabKeyboard) updateKeyboardMode()
        }.also { binding.tabRemote.isChecked = true }
    }

    private fun bindRemoteKeys() {
        listOf(
            binding.btnPower to RemoteCommand.POWER,
            binding.btnMute to RemoteCommand.MUTE,
            binding.btnVolUp to RemoteCommand.VOL_UP,
            binding.btnVolDown to RemoteCommand.VOL_DOWN,
            binding.btnChUp to RemoteCommand.CH_UP,
            binding.btnChDown to RemoteCommand.CH_DOWN,
            binding.btnUp to RemoteCommand.UP,
            binding.btnDown to RemoteCommand.DOWN,
            binding.btnLeft to RemoteCommand.LEFT,
            binding.btnRight to RemoteCommand.RIGHT,
            binding.btnOk to RemoteCommand.OK,
            binding.btnHome to RemoteCommand.HOME,
            binding.btnBack to RemoteCommand.BACK,
            binding.btnMenu to RemoteCommand.MENU,
            binding.btnPadOk to RemoteCommand.OK,
            binding.btnPadBack to RemoteCommand.BACK,
            binding.btnPadHome to RemoteCommand.HOME,
            binding.btnNumBack to RemoteCommand.BACK,
            binding.btnNumOk to RemoteCommand.OK,
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
        ).forEach { (view, command) ->
            view.setOnClickListener { sendSingle(it, command) }
        }
        binding.btnInput.setOnClickListener {
            ButtonHaptics.click(it)
            onInputPressed()
        }
        bindAppShortcuts()
    }

    private fun setupVoice() {
        voice = VoiceController(this)
        voice.listener = object : VoiceController.Listener {
            override fun onListening(active: Boolean) {
                binding.voiceHint.text = getString(if (active) R.string.voice_listening else R.string.voice_hold)
                binding.voiceHint.setTextColor(getColor(if (active) R.color.neon_teal else R.color.text_faint))
                binding.voiceLabel.text = getString(if (active) R.string.voice_listening else R.string.voice)
                binding.voiceLabel.setTextColor(getColor(if (active) R.color.neon_teal else R.color.text_faint))
                binding.btnVoice.iconTint = getColorStateList(if (active) R.color.neon_teal else R.color.neon_teal)
                if (active) pulseVoiceWave(true) else pulseVoiceWave(false)
            }
            override fun onLevel(level: Float) {
                binding.voiceWave.scaleY = 0.55f + level * 0.9f
                binding.voiceWave.scaleX = 0.9f + level * 0.2f
            }
            override fun onPcm(samples: ByteArray) {
                if (!voiceStreaming) return
                ioExecutor.execute {
                    val result = router.sendVoicePcm(samples)
                    if (result is TransmitResult.Failed) mainHandler.post { onResult(result) }
                }
            }
            override fun onDictation(text: String) {
                snack(getString(R.string.voice_sent_fmt, text))
                sendTextToTv(listOf(text))
            }
            override fun onError(message: String) = snack(message)
        }
        val hold = android.view.View.OnTouchListener { v, event ->
            when (event.actionMasked) {
                android.view.MotionEvent.ACTION_DOWN -> {
                    ButtonHaptics.vibrate(this)
                    beginVoice()
                    true
                }
                android.view.MotionEvent.ACTION_UP, android.view.MotionEvent.ACTION_CANCEL -> {
                    endVoice()
                    v.performClick()
                    true
                }
                else -> false
            }
        }
        binding.btnVoice.setOnTouchListener(hold)
        binding.voiceBar.setOnTouchListener(hold)
    }

    private fun pulseVoiceWave(on: Boolean) {
        voiceLevelAnimator?.cancel()
        if (!on) {
            binding.voiceWave.animate().scaleX(1f).scaleY(1f).setDuration(120).start()
            binding.voiceWave.alpha = 1f
            return
        }
        voiceLevelAnimator = android.animation.ValueAnimator.ofFloat(0.7f, 1f).apply {
            duration = 500
            repeatMode = android.animation.ValueAnimator.REVERSE
            repeatCount = android.animation.ValueAnimator.INFINITE
            addUpdateListener { binding.voiceWave.alpha = it.animatedValue as Float }
            start()
        }
    }

    private fun beginVoice() {
        if (!requireConnection()) return
        if (!voice.hasMicPermission()) {
            micPermissionRequest.launch(android.Manifest.permission.RECORD_AUDIO)
            return
        }
        startVoiceSession()
    }

    private fun startVoiceSession() {
        if (!isConnected()) return
        if (router.supportsVoice()) {
            // Google TV: open Assistant, then stream PCM from the phone mic
            ioExecutor.execute {
                val started = router.startVoice()
                mainHandler.post {
                    if (started is TransmitResult.Failed) {
                        onResult(started)
                        // Fall back to on-device dictation so the user still gets something
                        voiceStreaming = false
                        voice.startDictation()
                    } else {
                        voiceStreaming = true
                        voice.startStreaming()
                    }
                }
            }
        } else {
            // Samsung / LG / Roku / Bluetooth / IR: dictate on the phone, type into the TV
            voiceStreaming = false
            voice.startDictation()
        }
    }

    private fun endVoice() {
        if (voiceStreaming) {
            voiceStreaming = false
            voice.stopStreaming()
            ioExecutor.execute {
                val result = router.endVoice()
                mainHandler.post { if (result is TransmitResult.Failed) onResult(result) }
            }
        } else {
            voice.stopDictation()
        }
    }

    private fun bindAppShortcuts() {
        listOf(
            binding.btnNetflix to TvApp.NETFLIX,
            binding.btnYoutube to TvApp.YOUTUBE,
            binding.btnDisney to TvApp.DISNEY_PLUS,
            binding.btnPrime to TvApp.PRIME_VIDEO,
            binding.btnSpotify to TvApp.SPOTIFY,
            binding.btnShahid to TvApp.SHAHID
        ).forEach { (view, app) ->
            view.setOnClickListener {
                ButtonHaptics.click(it)
                launchApp(app)
            }
        }
    }

    private fun launchApp(app: TvApp) {
        if (!requireConnection()) return
        if (activeLink == ControlLink.IR) {
            snack(getString(R.string.app_need_wifi), getString(R.string.connect)) { openConnectSheet(ControlLink.WIFI) }
            return
        }
        snack(getString(R.string.app_opening_fmt, app.label))
        ioExecutor.execute {
            val result = router.launchApp(app)
            mainHandler.post { onResult(result) }
        }
    }

    private fun onInputPressed() {
        if (!requireConnection()) return
        ioExecutor.execute {
            val result = router.send(selectedBrand, RemoteCommand.INPUT)
            mainHandler.post { onResult(result) }
        }
    }

    private fun requireConnection(): Boolean {
        if (isConnected()) return true
        if (connecting != null) {
            snack(getString(R.string.status_connecting))
            return false
        }
        if (activeLink != null) {
            activeLink = null
            updateHeader()
        }
        snack(getString(R.string.need_connection), getString(R.string.connect)) { openConnectSheet() }
        return false
    }

    private fun sendSingle(view: View?, command: RemoteCommand) {
        if (view != null) ButtonHaptics.click(view) else ButtonHaptics.vibrate(this)
        sendSingle(command)
    }

    private fun sendSingle(command: RemoteCommand) {
        if (!requireConnection()) return
        ioExecutor.execute {
            val result = router.send(selectedBrand, command)
            mainHandler.post { onResult(result) }
        }
    }

    private fun onResult(result: TransmitResult) {
        if (result is TransmitResult.Failed) {
            updateHeader()
            snack(result.reason)
        }
    }

    private fun sendSequence(commands: List<RemoteCommand>, onDone: (() -> Unit)? = null) {
        if (commands.isEmpty() || !requireConnection()) {
            onDone?.invoke()
            return
        }
        ioExecutor.execute {
            for ((index, command) in commands.withIndex()) {
                val result = router.send(selectedBrand, command)
                if (result is TransmitResult.Failed) {
                    mainHandler.post { onResult(result); onDone?.invoke() }
                    return@execute
                }
                if (index < commands.lastIndex) Thread.sleep(120)
            }
            mainHandler.post { onDone?.invoke() }
        }
    }

    // ------------------------------------------------------------ touchpad

    private fun setupTouchpad() {
        binding.touchpadView.listener = object : TouchpadView.Listener {
            override fun onIrCommands(commands: List<RemoteCommand>) {
                if (commands.isNotEmpty()) ButtonHaptics.vibrate(this@MainActivity)
                sendSequence(commands)
            }

            override fun onStatus(message: String) = Unit

            override fun onPointerDelta(dx: Float, dy: Float): Boolean {
                if (activeLink != ControlLink.BLUETOOTH || !bluetooth.isReady) return false
                bluetooth.moveMouse((dx * MOUSE_GAIN).roundToInt(), (dy * MOUSE_GAIN).roundToInt())
                return true
            }

            override fun onTap(): Boolean {
                if (activeLink != ControlLink.BLUETOOTH || !bluetooth.isReady) return false
                ButtonHaptics.vibrate(this@MainActivity)
                bluetooth.click()
                return true
            }
        }
    }

    // ------------------------------------------------------------ keyboard

    private fun setupKeyboard() {
        binding.typeField.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) = Unit
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) = Unit
            override fun afterTextChanged(s: Editable?) {
                if (suppressTypeWatcher) return
                val now = s?.toString().orEmpty()
                val diff = typingDiff(lastTyped, now)
                lastTyped = now
                if (diff.isNotEmpty()) sendTextToTv(diff)
            }
        })
        binding.typeField.setOnEditorActionListener { _, actionId, event ->
            val enter = actionId == EditorInfo.IME_ACTION_SEARCH || actionId == EditorInfo.IME_ACTION_DONE ||
                actionId == EditorInfo.IME_ACTION_GO || event?.keyCode == KeyEvent.KEYCODE_ENTER
            if (enter) {
                sendTextToTv(listOf("\n"))
                clearTypeField()
            }
            enter
        }
        binding.btnKbDelete.setOnClickListener {
            ButtonHaptics.click(it)
            val text = binding.typeField.text?.toString().orEmpty()
            if (text.isNotEmpty()) {
                binding.typeField.setText(text.dropLast(1))
                binding.typeField.setSelection(binding.typeField.length())
            } else {
                sendTextToTv(listOf("\b"))
            }
        }
        binding.btnKbEnter.setOnClickListener {
            ButtonHaptics.click(it)
            sendTextToTv(listOf("\n"))
            clearTypeField()
        }
        binding.btnResetKeyboardCursor.setOnClickListener {
            ButtonHaptics.click(it)
            keyboardNavigator.resetCursor()
        }
        buildKeyboardGrid(binding.keyboardGrid)
        updateKeyboardMode()
    }

    private fun clearTypeField() {
        suppressTypeWatcher = true
        binding.typeField.setText("")
        suppressTypeWatcher = false
        lastTyped = ""
    }

    private fun updateKeyboardMode() {
        // Direct typing is the default; the arrow-key keyboard is only for links that can't type
        val direct = when (activeLink) {
            null -> true
            ControlLink.IR -> false
            else -> router.supportsText()
        }
        binding.directTyping.visibility = if (direct) View.VISIBLE else View.GONE
        binding.gridTyping.visibility = if (direct) View.GONE else View.VISIBLE
        binding.keyboardHint.text = getString(if (direct) R.string.keyboard_direct_hint else R.string.keyboard_grid_hint)
    }

    private fun sendTextToTv(chunks: List<String>) {
        if (!requireConnection()) return
        if (!router.supportsText()) {
            chunks.joinToString("").forEach { onGridKey(it) }
            return
        }
        ioExecutor.execute {
            for (chunk in chunks) {
                val result = router.sendText(chunk)
                if (result is TransmitResult.Failed) {
                    mainHandler.post { onResult(result) }
                    return@execute
                }
            }
        }
    }

    private fun buildKeyboardGrid(grid: GridLayout) {
        grid.removeAllViews()
        TvKeyboardNavigator.DEFAULT_LAYOUT.forEach { row ->
            row.forEach { ch ->
                val label = when (ch) {
                    ' ' -> "␣"
                    '↵' -> "↵"
                    else -> ch.uppercaseChar().toString()
                }
                grid.addView(gridKey(label, 1f) { onGridKey(ch) })
            }
        }
        grid.addView(gridKey("⌫", 2f) { onGridKey('\b') })
        grid.addView(gridKey(getString(R.string.ok), 2f) { sendSingle(RemoteCommand.OK) })
        grid.addView(gridKey(getString(R.string.back), 2f) { sendSingle(RemoteCommand.BACK) })
    }

    private fun gridKey(label: String, weight: Float, onClick: () -> Unit): MaterialButton =
        MaterialButton(this, null, com.google.android.material.R.attr.materialButtonStyle).apply {
            text = label
            textSize = 15f
            isAllCaps = false
            minimumHeight = 0
            minHeight = dp(48)
            minWidth = 0
            minimumWidth = 0
            insetTop = 0
            insetBottom = 0
            setPadding(0, 0, 0, 0)
            cornerRadius = dp(12)
            backgroundTintList = getColorStateList(R.color.surface_high)
            setTextColor(getColor(R.color.text_primary))
            stateListAnimator = null
            layoutParams = GridLayout.LayoutParams().apply {
                width = 0
                height = dp(48)
                columnSpec = GridLayout.spec(GridLayout.UNDEFINED, weight.toInt(), weight)
                setMargins(dp(2), dp(3), dp(2), dp(3))
            }
            setOnClickListener {
                ButtonHaptics.click(it)
                onClick()
            }
        }

    private fun onGridKey(ch: Char) {
        if (!requireConnection()) return
        if (gridTypingBusy) {
            snack(getString(R.string.typing_busy))
            return
        }
        val commands = keyboardNavigator.typeCharacter(if (ch == '\n') '↵' else ch)
        if (commands.isEmpty()) return
        gridTypingBusy = true
        sendSequence(commands) { gridTypingBusy = false }
    }

    // ------------------------------------------------------------ hardware keys / mouse

    override fun dispatchKeyEvent(event: KeyEvent): Boolean {
        if (currentFocus is EditText) return super.dispatchKeyEvent(event)
        if (event.action != KeyEvent.ACTION_DOWN || event.repeatCount > 0) {
            return super.dispatchKeyEvent(event)
        }
        val command = when (event.keyCode) {
            KeyEvent.KEYCODE_DPAD_UP -> RemoteCommand.UP
            KeyEvent.KEYCODE_DPAD_DOWN -> RemoteCommand.DOWN
            KeyEvent.KEYCODE_DPAD_LEFT -> RemoteCommand.LEFT
            KeyEvent.KEYCODE_DPAD_RIGHT -> RemoteCommand.RIGHT
            KeyEvent.KEYCODE_ENTER, KeyEvent.KEYCODE_DPAD_CENTER, KeyEvent.KEYCODE_NUMPAD_ENTER -> RemoteCommand.OK
            KeyEvent.KEYCODE_ESCAPE -> RemoteCommand.BACK
            KeyEvent.KEYCODE_VOLUME_UP -> if (isConnected()) RemoteCommand.VOL_UP else null
            KeyEvent.KEYCODE_VOLUME_DOWN -> if (isConnected()) RemoteCommand.VOL_DOWN else null
            else -> null
        }
        if (command != null) {
            sendSingle(null, command)
            return true
        }
        return super.dispatchKeyEvent(event)
    }

    override fun onGenericMotionEvent(event: MotionEvent): Boolean {
        if (event.source and InputDevice.SOURCE_CLASS_POINTER == 0 || !isConnected()) {
            return super.onGenericMotionEvent(event)
        }
        when (event.actionMasked) {
            MotionEvent.ACTION_HOVER_MOVE, MotionEvent.ACTION_MOVE -> {
                val relX = event.getAxisValue(MotionEvent.AXIS_RELATIVE_X)
                val relY = event.getAxisValue(MotionEvent.AXIS_RELATIVE_Y)
                val commands = hardwarePointer.onMove(relX, relY)
                if (commands.isNotEmpty()) {
                    sendSequence(commands)
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

    // ------------------------------------------------------------ auto reconnect

    private val wifiCallback = object : ConnectivityManager.NetworkCallback() {
        override fun onAvailable(network: Network) {
            mainHandler.postDelayed({ autoReconnectIfDropped() }, 1500)
        }
    }

    override fun onResume() {
        super.onResume()
        autoReconnectIfDropped()
    }

    private var lastAutoReconnect = 0L

    /** Wi‑Fi is the chosen link (not disconnected by the user) but the TV isn't connected. */
    private fun autoReconnectIfDropped() {
        if (isFinishing || connecting != null || sheet?.isShowing == true) return
        val wantsWifi = activeLink == ControlLink.WIFI ||
            (activeLink == null && prefs.getString(PREF_LINK, null) == ControlLink.WIFI.name)
        if (!wantsWifi || wifi.isReady || wifi.lastTv() == null) return
        val now = android.os.SystemClock.elapsedRealtime()
        if (now - lastAutoReconnect < 30_000) return
        lastAutoReconnect = now
        reconnectWifi()
    }

    // ------------------------------------------------------------ misc

    private fun scheduleAutomationCommands(names: Array<String>) {
        ioExecutor.execute {
            var waits = 0
            while (!wifi.isReady && waits < 100) {
                Thread.sleep(150)
                waits++
            }
            if (!wifi.isReady) return@execute
            for (name in names) {
                val command = runCatching { RemoteCommand.valueOf(name.trim().uppercase()) }.getOrNull() ?: continue
                val result = router.send(selectedBrand, command)
                mainHandler.post { onResult(result) }
                Thread.sleep(250)
            }
        }
    }

    private fun snack(message: String, actionLabel: String? = null, action: (() -> Unit)? = null) {
        val bar = Snackbar.make(binding.root, message, if (action != null) Snackbar.LENGTH_LONG else Snackbar.LENGTH_SHORT)
            .setBackgroundTint(getColor(R.color.surface_high))
            .setTextColor(getColor(R.color.text_primary))
            .setActionTextColor(getColor(R.color.accent))
        if (actionLabel != null && action != null) bar.setAction(actionLabel) { action() }
        bar.show()
    }

    private fun dp(value: Int): Int = (value * resources.displayMetrics.density).roundToInt()

    override fun onDestroy() {
        promptDialog?.dismiss()
        sheet?.dismiss()
        runCatching { getSystemService(ConnectivityManager::class.java).unregisterNetworkCallback(wifiCallback) }
        if (::voice.isInitialized) voice.release()
        voiceLevelAnimator?.cancel()
        bluetooth.stop()
        ioExecutor.shutdownNow()
        scanExecutor.shutdownNow()
        netExecutor.execute { wifi.disconnect() }
        netExecutor.shutdown()
        super.onDestroy()
    }

    companion object {
        const val EXTRA_WIFI_IP = "wifi_ip"
        const val EXTRA_SEND_COMMANDS = "send_commands"
        private const val PREF_LINK = "link"
        private const val PREF_BRAND = "ir_brand"
        private const val PREF_BT = "bt_address"
        private const val MOUSE_GAIN = 1.4f

        /** Minimal edits that turn [old] into [new]: one "\b" per removed char, then the inserted text. */
        fun typingDiff(old: String, new: String): List<String> {
            var prefix = 0
            while (prefix < old.length && prefix < new.length && old[prefix] == new[prefix]) prefix++
            val result = ArrayList<String>()
            repeat(old.length - prefix) { result += "\b" }
            val inserted = new.substring(prefix)
            if (inserted.isNotEmpty()) result += inserted
            return result
        }
    }
}
