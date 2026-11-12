package com.irremote.tv.bluetooth

import android.Manifest
import android.annotation.SuppressLint
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothHidDevice
import android.bluetooth.BluetoothHidDeviceAppSdpSettings
import android.bluetooth.BluetoothManager
import android.bluetooth.BluetoothProfile
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import androidx.annotation.RequiresApi
import com.irremote.tv.control.InputSource
import com.irremote.tv.control.RemoteTarget
import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import java.util.concurrent.Executors

/**
 * Makes the phone act as a Bluetooth keyboard + media remote + mouse (HID Device profile, Android 9+).
 * Pair it from the TV's Bluetooth settings ("Add accessory / remote"), or connect to an already‑paired TV.
 */
@SuppressLint("MissingPermission")
class BluetoothHidRemote(private val context: Context) : RemoteTarget {

    interface Listener {
        fun onBluetoothState(message: String, connected: Boolean)
    }

    var listener: Listener? = null

    private val adapter: BluetoothAdapter? =
        (context.getSystemService(Context.BLUETOOTH_SERVICE) as? BluetoothManager)?.adapter
    private val callbackExecutor = Executors.newSingleThreadExecutor()

    @Volatile private var hid: BluetoothHidDevice? = null
    @Volatile private var registered = false
    @Volatile private var host: BluetoothDevice? = null
    private var pendingConnect: BluetoothDevice? = null
    private var callback: Any? = null

    val isSupported: Boolean
        get() = Build.VERSION.SDK_INT >= Build.VERSION_CODES.P && adapter != null

    val isEnabled: Boolean get() = adapter?.isEnabled == true

    val connectedName: String? get() = host?.let { deviceName(it) }

    override val isReady: Boolean get() = host != null && hid != null
    override val supportsText: Boolean = true

    fun hasPermission(): Boolean =
        Build.VERSION.SDK_INT < Build.VERSION_CODES.S ||
            context.checkSelfPermission(Manifest.permission.BLUETOOTH_CONNECT) == PackageManager.PERMISSION_GRANTED

    fun bondedDevices(): List<BluetoothDevice> =
        if (!hasPermission()) emptyList()
        else adapter?.bondedDevices?.sortedBy { deviceName(it) }.orEmpty()

    fun deviceName(device: BluetoothDevice): String =
        runCatching { device.name }.getOrNull()?.takeIf { it.isNotBlank() } ?: device.address

    /** Registers the HID app with the system; safe to call repeatedly. */
    fun start() {
        if (!isSupported || !hasPermission() || hid != null) return
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) startProxy()
    }

    @RequiresApi(Build.VERSION_CODES.P)
    private fun startProxy() {
        adapter?.getProfileProxy(context, object : BluetoothProfile.ServiceListener {
            override fun onServiceConnected(profile: Int, proxy: BluetoothProfile) {
                if (profile != BluetoothProfile.HID_DEVICE) return
                val device = proxy as BluetoothHidDevice
                hid = device
                register(device)
            }

            override fun onServiceDisconnected(profile: Int) {
                hid = null
                registered = false
                host = null
                notify("Bluetooth remote service stopped", false)
            }
        }, BluetoothProfile.HID_DEVICE)
    }

    @RequiresApi(Build.VERSION_CODES.P)
    private fun register(device: BluetoothHidDevice) {
        val sdp = BluetoothHidDeviceAppSdpSettings(
            "IR TV Remote",
            "Keyboard, mouse and TV remote",
            "IR TV Remote",
            BluetoothHidDevice.SUBCLASS1_COMBO,
            HidReports.DESCRIPTOR
        )
        val cb = object : BluetoothHidDevice.Callback() {
            override fun onAppStatusChanged(pluggedDevice: BluetoothDevice?, registered: Boolean) {
                this@BluetoothHidRemote.registered = registered
                Log.i(TAG, "HID app registered=$registered plugged=${pluggedDevice?.address}")
                if (!registered) return
                val target = pendingConnect ?: pluggedDevice
                pendingConnect = null
                if (target != null) device.connect(target)
                else notify("Ready — pair this phone from the TV's Bluetooth settings", false)
            }

            override fun onConnectionStateChanged(device: BluetoothDevice, state: Int) {
                when (state) {
                    BluetoothProfile.STATE_CONNECTED -> {
                        host = device
                        notify("Connected to ${deviceName(device)}", true)
                    }
                    BluetoothProfile.STATE_CONNECTING -> notify("Connecting to ${deviceName(device)}…", false)
                    BluetoothProfile.STATE_DISCONNECTED -> {
                        if (host?.address == device.address) host = null
                        notify("Disconnected from ${deviceName(device)}", false)
                    }
                }
            }
        }
        callback = cb
        device.registerApp(sdp, null, null, callbackExecutor, cb)
    }

    fun connect(device: BluetoothDevice) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.P) return
        val h = hid
        if (h == null || !registered) {
            pendingConnect = device
            start()
            notify("Connecting to ${deviceName(device)}…", false)
            return
        }
        if (!h.connect(device)) notify("Could not connect to ${deviceName(device)} — pair it first", false)
    }

    fun disconnect() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.P) return
        host?.let { hid?.disconnect(it) }
    }

    fun stop() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.P) return
        runCatching {
            disconnect()
            if (registered) hid?.unregisterApp()
            hid?.let { adapter?.closeProfileProxy(BluetoothProfile.HID_DEVICE, it) }
        }
        hid = null
        registered = false
        host = null
    }

    private fun notify(message: String, connected: Boolean) {
        listener?.onBluetoothState(message, connected)
    }

    private fun report(id: Int, data: ByteArray): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.P) return false
        val h = hid ?: return false
        val target = host ?: return false
        return h.sendReport(target, id, data)
    }

    private fun press(key: HidReports.Key): TransmitResult {
        if (!isReady) return TransmitResult.Failed("Connect a TV in the Bluetooth panel first")
        val ok = when (key) {
            is HidReports.Key.Keyboard ->
                report(HidReports.ID_KEYBOARD, HidReports.keyboard(key.usage, key.modifiers)) &&
                    report(HidReports.ID_KEYBOARD, HidReports.KEYBOARD_RELEASE)
            is HidReports.Key.Consumer ->
                report(HidReports.ID_CONSUMER, HidReports.consumer(key.usage)) &&
                    report(HidReports.ID_CONSUMER, HidReports.CONSUMER_RELEASE)
        }
        return if (ok) TransmitResult.NETWORK_SENT else TransmitResult.Failed("Bluetooth send failed — reconnect")
    }

    override fun send(command: RemoteCommand): TransmitResult {
        val key = HidReports.keyFor(command)
            ?: return TransmitResult.Failed("${command.label} isn't available over Bluetooth — use IR or Wi‑Fi")
        return press(key)
    }

    override fun sendText(text: String): TransmitResult {
        for (ch in text) {
            val key = HidReports.keyForChar(ch) ?: continue
            val result = press(key)
            if (result is TransmitResult.Failed) return result
        }
        return TransmitResult.NETWORK_SENT
    }

    override fun inputSources(): List<InputSource> = emptyList()

    fun moveMouse(dx: Int, dy: Int): Boolean = report(HidReports.ID_MOUSE, HidReports.mouse(0, dx, dy))

    fun click(): Boolean =
        report(HidReports.ID_MOUSE, HidReports.mouse(1, 0, 0)) && report(HidReports.ID_MOUSE, HidReports.mouse(0, 0, 0))

    fun scroll(steps: Int): Boolean = report(HidReports.ID_MOUSE, HidReports.mouse(0, 0, 0, steps))

    companion object {
        private const val TAG = "BluetoothHidRemote"
    }
}
