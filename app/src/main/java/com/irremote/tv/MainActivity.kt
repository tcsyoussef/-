package com.irremote.tv

import android.os.Bundle
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.button.MaterialButton
import com.irremote.tv.databinding.ActivityMainBinding
import com.irremote.tv.ir.AndroidIrTransmitter
import com.irremote.tv.ir.IrTransmitter
import com.irremote.tv.ir.RemoteCommand
import com.irremote.tv.ir.TransmitResult
import com.irremote.tv.ir.TvBrand

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private lateinit var transmitter: IrTransmitter
    private var selectedBrand: TvBrand = TvBrand.SAMSUNG

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        transmitter = AndroidIrTransmitter(this)
        setupStatus()
        setupBrandSpinner()
        bindButtons()
    }

    private fun setupStatus() {
        binding.statusText.text = if (transmitter.hasBuiltInEmitter) {
            getString(R.string.status_ir_available)
        } else {
            getString(R.string.status_ir_unavailable)
        }
        binding.usbStatusText.text = getString(R.string.status_usb_ir_untested)
    }

    private fun setupBrandSpinner() {
        val brands = resources.getStringArray(R.array.tv_brands)
        binding.brandSpinner.adapter = ArrayAdapter(
            this,
            android.R.layout.simple_spinner_dropdown_item,
            brands
        )
        binding.brandSpinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(
                parent: AdapterView<*>?,
                view: View?,
                position: Int,
                id: Long
            ) {
                selectedBrand = TvBrand.fromDisplayName(brands[position])
            }

            override fun onNothingSelected(parent: AdapterView<*>?) = Unit
        }
    }

    private fun bindButtons() {
        val mapping = listOf(
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
            binding.btnInput to RemoteCommand.INPUT,
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
        )

        mapping.forEach { (button, command) ->
            button.setOnClickListener { sendCommand(command, button) }
        }
    }

    private fun sendCommand(command: RemoteCommand, button: MaterialButton) {
        when (val result = transmitter.transmit(selectedBrand, command)) {
            is TransmitResult.Sent -> {
                val mode = if (result.simulated) "simulated" else "transmitted"
                val message = "${selectedBrand.displayName} ${command.label} ($mode)"
                binding.lastCommandText.text = getString(R.string.last_command, message)
                button.isPressed = true
                button.postDelayed({ button.isPressed = false }, 120)
            }
            is TransmitResult.Failed -> {
                Toast.makeText(this, result.reason, Toast.LENGTH_SHORT).show()
            }
        }
    }
}
