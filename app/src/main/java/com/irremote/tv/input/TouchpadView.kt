package com.irremote.tv.input

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Canvas
import android.graphics.Paint
import android.graphics.RectF
import android.util.AttributeSet
import android.view.MotionEvent
import android.view.View
import kotlin.math.hypot

/**
 * On-screen mouse/touchpad. Swipes emit IR directions through [PointerController];
 * tap emits OK. This is not decorative — every gesture maps to IR commands.
 */
class TouchpadView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null
) : View(context, attrs) {

    interface Listener {
        fun onIrCommands(commands: List<com.irremote.tv.ir.RemoteCommand>)
        fun onStatus(message: String)
    }

    var listener: Listener? = null
    private val controller = PointerController()

    private var lastX = 0f
    private var lastY = 0f
    private var downX = 0f
    private var downY = 0f
    private var moved = false
    private var active = false

    private val fillPaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
        color = 0xFF1E293B.toInt()
        style = Paint.Style.FILL
    }
    private val strokePaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
        color = 0xFF334155.toInt()
        style = Paint.Style.STROKE
        strokeWidth = 3f
    }
    private val guidePaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
        color = 0xFF64748B.toInt()
        textAlign = Paint.Align.CENTER
        textSize = 36f
    }
    private val activePaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
        color = 0x332DD4BF
        style = Paint.Style.FILL
    }
    private val bounds = RectF()

    override fun onSizeChanged(w: Int, h: Int, oldw: Int, oldh: Int) {
        bounds.set(8f, 8f, w - 8f, h - 8f)
    }

    override fun onDraw(canvas: Canvas) {
        canvas.drawRoundRect(bounds, 28f, 28f, fillPaint)
        canvas.drawRoundRect(bounds, 28f, 28f, strokePaint)
        if (active) {
            canvas.drawRoundRect(bounds, 28f, 28f, activePaint)
        }
        canvas.drawText("TOUCHPAD", width / 2f, height / 2f - 12f, guidePaint)
        guidePaint.textSize = 28f
        canvas.drawText("swipe = move · tap = OK", width / 2f, height / 2f + 28f, guidePaint)
        guidePaint.textSize = 36f
    }

    @SuppressLint("ClickableViewAccessibility")
    override fun onTouchEvent(event: MotionEvent): Boolean {
        when (event.actionMasked) {
            MotionEvent.ACTION_DOWN -> {
                parent.requestDisallowInterceptTouchEvent(true)
                active = true
                moved = false
                downX = event.x
                downY = event.y
                lastX = event.x
                lastY = event.y
                controller.reset()
                invalidate()
                return true
            }
            MotionEvent.ACTION_MOVE -> {
                val dx = event.x - lastX
                val dy = event.y - lastY
                lastX = event.x
                lastY = event.y
                if (hypot(event.x - downX, event.y - downY) > 18f) {
                    moved = true
                }
                val commands = controller.onMove(dx, dy)
                if (commands.isNotEmpty()) {
                    listener?.onIrCommands(commands)
                    listener?.onStatus("Mouse → ${commands.joinToString { it.label }}")
                }
                return true
            }
            MotionEvent.ACTION_UP, MotionEvent.ACTION_CANCEL -> {
                parent.requestDisallowInterceptTouchEvent(false)
                active = false
                invalidate()
                if (!moved && event.actionMasked == MotionEvent.ACTION_UP) {
                    val cmd = controller.onClick()
                    listener?.onIrCommands(listOf(cmd))
                    listener?.onStatus("Mouse → OK")
                    performClick()
                }
                controller.reset()
                return true
            }
        }
        return super.onTouchEvent(event)
    }
}
