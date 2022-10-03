extends Panel


@onready var data := $ScrollContainer/VBoxContainer/PlayerData
@onready var unit := $ScrollContainer/VBoxContainer/UnitPanel


func _on_UI_updated(event: Dictionary) -> void:
	# Update player UI.
	if event.has("loot"):
		data.set_text("Collected loot: " + str(event["loot"]))
	# Update sub-player UI.
	unit.update_unit(event)

