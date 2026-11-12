package com.irremote.tv

import android.graphics.Bitmap
import android.graphics.Canvas
import android.view.View
import android.widget.TextView
import com.google.android.material.bottomsheet.BottomSheetDialog
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertTrue
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.Robolectric
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config
import org.robolectric.annotation.GraphicsMode
import org.robolectric.shadows.ShadowDialog
import org.robolectric.shadows.ShadowLooper
import java.io.File

@RunWith(RobolectricTestRunner::class)
@GraphicsMode(GraphicsMode.Mode.NATIVE)
@Config(sdk = [34], qualifiers = "w411dp-h891dp-xxhdpi")
class MainActivityUiTest {

    private fun shot(view: View, name: String) {
        val dir = System.getenv("UI_SCREENSHOTS") ?: return
        ShadowLooper.idleMainLooper()
        val w = view.resources.displayMetrics.widthPixels
        val h = view.resources.displayMetrics.heightPixels
        view.measure(View.MeasureSpec.makeMeasureSpec(w, View.MeasureSpec.EXACTLY), View.MeasureSpec.makeMeasureSpec(h, View.MeasureSpec.EXACTLY))
        view.layout(0, 0, w, h)
        val bitmap = Bitmap.createBitmap(view.width, view.height, Bitmap.Config.ARGB_8888)
        view.draw(Canvas(bitmap))
        File(dir).mkdirs()
        File(dir, "$name.png").outputStream().use { bitmap.compress(Bitmap.CompressFormat.PNG, 100, it) }
    }

    @Test
    fun launchesAndShowsEveryPageAndTheConnectSheet() {
        val activity = Robolectric.buildActivity(MainActivity::class.java).setup().get()
        ShadowLooper.idleMainLooper(1, java.util.concurrent.TimeUnit.SECONDS)
        val root = activity.findViewById<View>(R.id.root)

        // First launch opens the connect sheet automatically
        val sheet = ShadowDialog.getLatestDialog() as? BottomSheetDialog
        assertNotNull(sheet)
        assertTrue(sheet!!.isShowing)
        val sheetRoot = sheet.window!!.decorView
        shot(sheetRoot, "2_connect_sheet_wifi")
        sheetRoot.findViewById<View>(R.id.sheetTabIr).performClick()
        shot(sheetRoot, "3_connect_sheet_ir")
        sheetRoot.findViewById<View>(R.id.sheetTabBt).performClick()
        shot(sheetRoot, "4_connect_sheet_bt")
        sheet.dismiss()

        assertEquals(activity.getString(R.string.connect), activity.findViewById<TextView>(R.id.btnConnection).text)
        shot(root, "1_remote")

        // Pressing a key while disconnected doesn't crash and reopens nothing unexpected
        activity.findViewById<View>(R.id.btnHome).performClick()

        activity.findViewById<View>(R.id.tabTouchpad).performClick()
        assertEquals(View.VISIBLE, activity.findViewById<View>(R.id.pageTouchpad).visibility)
        shot(root, "5_touchpad")
        activity.findViewById<View>(R.id.tabKeyboard).performClick()
        assertEquals(View.VISIBLE, activity.findViewById<View>(R.id.directTyping).visibility)
        shot(root, "6_keyboard")
        activity.findViewById<View>(R.id.tabNumbers).performClick()
        shot(root, "7_numbers")

        // Connect button toggles to Disconnect while connecting, and back
        activity.findViewById<View>(R.id.btnConnection).performClick()
        ShadowLooper.idleMainLooper()
        val reopened = ShadowDialog.getLatestDialog() as BottomSheetDialog
        val ip = reopened.window!!.decorView
        ip.findViewById<View>(R.id.btnShowIp).performClick()
        ip.findViewById<android.widget.EditText>(R.id.ipInput).setText("127.0.0.1")
        ip.findViewById<View>(R.id.btnIpConnect).performClick()
        assertEquals(activity.getString(R.string.disconnect), activity.findViewById<TextView>(R.id.btnConnection).text)
        reopened.dismiss()
        activity.findViewById<View>(R.id.btnConnection).performClick()
        assertEquals(activity.getString(R.string.connect), activity.findViewById<TextView>(R.id.btnConnection).text)
    }
}
