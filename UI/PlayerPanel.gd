extends Panel

@onready var data = $VBoxContainer/PlayerData
@onready var unit : Node = $VBoxContainer/UnitPanel


func _on_UI_updated(event : Dictionary) -> void:
	# Update player UI.
	if event.has("loot"):
		data.set_text("Collected loot: " + str(event["loot"]))
	# Update sub-player UI.
	unit.update_unit(event)

