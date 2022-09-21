extends Panel

@onready var data = $VBoxContainer/PlayerData
@onready var unit : Node = $VBoxContainer/UnitPanel


func _on_UI_updated(event : Dictionary) -> void:
	# Update player UI.
	if event.has("loot"):
		data.set_text("Collected loot: " + str(event["loot"]))
	# Update sub-player UI.
	unit.update_unit(event)



func _on_unit_panel_gui_input(event: InputEvent) -> void:
	# When the unit is clicked, highlight it.
	# When allow the unit to 
	
	pass # Replace with function body.
