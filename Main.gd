extends Node2D


var encounter_counter := 0
var card_counter := 0
var battle_counter := 0

var mission = preload("res://missions/NewMission.gd").new()
var player = preload("res://Player.gd").new()

func _ready() -> void:
	update_UI()


func update_UI() -> void:
	$Panel/VBoxContainer/MissionTitle.set_text(mission.title)
	$Panel/VBoxContainer/EncounterTitle.set_text(mission.encounters[encounter_counter].title)
	$Panel/VBoxContainer/Card/CardTitle.set_text(mission.encounters[encounter_counter].cards[card_counter].title)
	$Panel/VBoxContainer/Card/CardDescription.set_text(mission.encounters[encounter_counter].cards[card_counter].description)
	var battle_count_text = "Battle Count: " + str(battle_counter)
	$Panel/VBoxContainer/BattleCount.set_text(battle_count_text)
	var soldier_count_text = "SOLDIER COUNT: " + str(player.soldier_count)
	$Panel/VBoxContainer/SoldierCount.set_text(soldier_count_text)


func _on_FightButton_pressed() -> void:
	var success : bool
	
	if randf() > 0.5:
		print("SUCCESS!")
		success = true
	else:
		print("Failure.")
		success = false
		player.soldier_count -= 1
		print_soldier_count()
	
	card_counter += 1
	battle_counter += 1
	
	check_player()
	check_progress()
	
	update_log(success)
	update_UI()


func update_log(value: bool) -> void:
	var log_text: String = $Panel/VBoxContainer/Control/Log.get_text()
	var new_text : String
	if value:
		new_text = "> Battle successful!"
	else:
		new_text = "> Battle unsuccessful. 1 soldier lost."
	
	log_text = new_text + "\n" + log_text
	$Panel/VBoxContainer/Control/Log.set_text(log_text)


func check_player() -> void:
	if player.soldier_count <= 0:
		print("YOU HAVE LOST.")
		print_soldier_count()


func check_progress() -> void:
	if card_counter >= mission.encounters[encounter_counter].cards.size():
		card_counter = 0
		encounter_counter += 1
	
	if encounter_counter >= mission.encounters.size():
		$Panel/VBoxContainer/FightButton.set_disabled(true)
		print("YOU HAVE WON.")
		print_soldier_count()
		encounter_counter = 0


func print_soldier_count() -> void:
	print("Soldiers remaining: " + str(player.soldier_count))
