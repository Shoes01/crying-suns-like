extends Node

signal UI_updated(event)

var battle_counter := 0
var card_counter := 0
var encounter_counter := 0
var mission_counter := 1

var combat_engine = get_node("CombatEngine")
var player : Player
var mission : Mission
var chosen_strategy : String = "none"


func prepare_mission(new_mission : Mission) -> void:
	mission = new_mission


func prepare_player(new_player : Player) -> void:
	player = new_player

# Related to a signal.
func _on_encounter_clicked(encounter : Encounter) -> void:
	var event := {}
	if chosen_strategy == "none":
		return
	else:
		print("Prepare encounter.")
		event["new_encounter"] = encounter
		UI_updated.emit(event)

# Related to a signal.
func _on_strategy_chosen(value: String) -> void:
	chosen_strategy = value

# Related to a signal.
func _on_draw_button_pressed() -> void:
	# Draw subsequent cards.
	
	_fight_the_new_card()
	_check_player() # Check to see if the player is dead.
	_check_encounter_progress() # Also check for win condition.
	_draw_new_card()
	# Update the unit UI.
	## Until units are properly added, I will do this.
	var event := {}
	event["player_hack"] = player
	emit_signal("UI_updated", event)


func _draw_new_card() -> void:
	if Global.game_state == "DEFEAT" or Global.game_state == "VICTORY":
		return
	var event := {}
	# Increment counter.
	card_counter += 1
	# CHECK IF THERE IS A NEW CARD.
	## Otherwise, new encounter.
	if card_counter == mission.encounters[encounter_counter].cards.size():
		_prepare_next_encounter()
	# Emit a signal to update the UI with this card.
	var new_card : Card = mission.encounters[encounter_counter].cards[card_counter]
	event["new_card"] = new_card
	emit_signal("UI_updated", event)


func _fight_the_new_card() -> void:
	var event := {}
	# Determine the outcome of the card.
	var success : bool = combat_engine.card_vs_unit(mission.encounters[encounter_counter].cards[card_counter], player)
	# Crude method of tracking progress. TODO : Use this for the log.
	battle_counter += 1
	# Log the event.
	var log_entry := {}
	log_entry["battle_counter"] = battle_counter
	log_entry["encounter_counter"] = encounter_counter
	log_entry["card_counter"] = card_counter
	log_entry["fight_won"] = success
	event["log_entry"] = log_entry
	# Emit the signal.
	emit_signal("UI_updated", event)


func _check_player() -> void:
	# Check if the player has any soldiers remaining.
	# NOTE: This will be replaced once units are a thing.
	if player.soldier_count <= 0:
		get_tree().change_scene_to_file("res://GameOver.tscn")
		Global.game_state = "DEFEAT"


func _prepare_next_encounter() -> void:
	card_counter = 0
	encounter_counter += 1
	# Update the UI.
	var event := {}
	var new_encounter : Encounter = mission.encounters[encounter_counter]
	event["new_encounter"] = new_encounter
	emit_signal("UI_updated", event)


func _check_encounter_progress() -> void:
	print("DEBUG: Card count: ", str(card_counter), ". Number of cards: ", str(mission.encounters[encounter_counter].cards.size()), ".")
	# Check if the mission is out of encounters.
	if encounter_counter >= mission.encounters.size():
		get_tree().change_scene_to_file("res://GameOver.tscn")
		encounter_counter = 0
		Global.game_state = "VICTORY"

