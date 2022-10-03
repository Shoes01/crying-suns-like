extends Node


signal UI_updated(event)

var battle_counter := 0
var card_counter := 0
var encounter_counter := 0
var mission_counter := 1

var player: Player
var chosen_strategy: Strategy
var chosen_encounter: Encounter
var combat_deck: Array

@onready var combat_engine := get_node("CombatEngine")


func _on_encounter_pressed(encounter: Encounter) -> void:
	chosen_encounter = encounter


func _on_strategy_chosen(value: Strategy) -> void:
	chosen_strategy = value


func _on_engage_pressed() -> void:
	if !chosen_strategy or !chosen_encounter: return
	var event := {}
	event["new_encounter"] = chosen_encounter
	combat_deck = combat_engine.build_deck(chosen_encounter, chosen_strategy)
	UI_updated.emit(event)


func _on_draw_button_pressed() -> void:
	_draw_new_card()
	_fight_the_new_card()
	_check_player() # Check to see if the player is dead.
	
	# Update the unit UI.
	var event := {}
	event["player_hack"] = player # PLACEHOLDER until I have proper units
	emit_signal("UI_updated", event)
	
	# Discard the top card from the deck.
	combat_deck.pop_front()
	
	# Check to see if the deck is empty.
	if combat_deck.size() == 0:
		event["deck_empty"] = true
		UI_updated.emit(event)
		chosen_strategy = null
		combat_deck = []


func _draw_new_card() -> void:
	if Global.game_state == "DEFEAT" or Global.game_state == "VICTORY":
		return
	var event := {}
	event["new_card"] = combat_deck[0]
	emit_signal("UI_updated", event)


func _fight_the_new_card() -> void:
	var event := {}
	# Determine the outcome of the card.
	var success: bool = combat_engine.card_vs_unit(combat_deck[0], player)
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
		get_tree().change_scene_to_file("res://otherscape/GameOver.tscn")
		Global.game_state = "DEFEAT"


func prepare_player(new_player : Player) -> void:
	player = new_player

