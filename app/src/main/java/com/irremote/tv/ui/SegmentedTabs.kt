package com.irremote.tv.ui

import com.google.android.material.button.MaterialButton

/** Single-choice row of rounded, checkable buttons (keeps every button's corners round). */
class SegmentedTabs(
    private val buttons: List<MaterialButton>,
    private val onSelected: (Int) -> Unit
) {
    var checkedId: Int = buttons.first().id
        private set

    init {
        buttons.forEach { button ->
            button.setOnClickListener { check(button.id) }
        }
    }

    fun check(id: Int) {
        buttons.forEach { it.isChecked = it.id == id }
        checkedId = id
        onSelected(id)
    }
}
