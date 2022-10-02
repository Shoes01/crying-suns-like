extends Panel


@onready var encounter := $VBoxContainer/EncounterPanel
@onready var log_node := $VBoxContainer/LogScroll/LogText


func _on_UI_updated(event: Dictionary) -> void:
	# Update mission-related UI.
	if event.has("log_entry"): 
		_update_log(event["log_entry"])
	if event.has("new_encounter"):
		set_visible(true)
	if event.has("deck_empty"):
		set_visible(false)
	# Update sub-mission UI.
	encounter.update_encounter(event)


func _update_log(log_entry: Dictionary) -> void:
	var log_text: String = log_node.get_text()
	var new_text := ""
	# In case of a new mission.
	if log_entry.has("new_mission"):
		log_node.set_text("NEW MISSION")
		return
	# Timestamp.
	## Battle count.
	new_text += "[" + str(log_entry["battle_counter"]) + "]"
	## Encounter.
	new_text += "[Enc_" + str(log_entry["encounter_counter"]) + "]"
	## Card.
	new_text += "[Card_" + str(log_entry["card_counter"]) + "] "
	# Success message.
	if log_entry["fight_won"] == true:
		new_text += "Success!"
	elif log_entry["fight_won"] == false:
		new_text += "Failure."
	# Update log.
	log_text = new_text + "\n" + log_text
	log_node.set_text(log_text)
