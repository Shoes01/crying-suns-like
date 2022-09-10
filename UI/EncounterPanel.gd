extends Panel

signal draw_button_pressed

@onready var card = $VBoxContainer/CardPanel
@onready var encounter_title = $VBoxContainer/EncounterTitle


func _ready() -> void:
	print("ENCOUNTER PANEL ready.")
	card.TEST()


func update_encounter(event : Dictionary) -> void:
	if event.has("new_encounter"):
		_update_encounter_panel(event["new_encounter"])
	
	card.update_card(event)


func _on_draw_button_pressed() -> void:
	print("BUTTON PRESSED")
	emit_signal("draw_button_pressed")


func _update_encounter_panel(new_encounter : Encounter) -> void:
	encounter_title.set_text(new_encounter.title)
