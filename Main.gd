extends Node2D

var mission_counter := 1
var encounter_counter := 0
var card_counter := 0
var battle_counter := 0

var mission = preload("res://missions/NewMission.gd").new()
var player = preload("res://Player.gd").new()
var combat_engine = preload("res://CombatEngine.gd").new()

func _ready() -> void:
	update_UI()
	# Update unit icons (just player for now)
	var unit_icons: Array = get_tree().get_nodes_in_group("UnitIcons")
	## Turn off all icons.
	for icon in unit_icons:
		icon.set_visible(false)
	## Turn on and set unit icons.
	var this_units_icons: Dictionary = player.icons
	var iterator = 0
	# Iterate over each icon.
	for icon in this_units_icons:
		# Iterate for the quantity of icons.
		for quantity in this_units_icons[icon]:
			unit_icons[iterator].set_visible(true)
			unit_icons[iterator].set_modulate(icon.color)
			unit_icons[iterator].set_texture(load(icon.sprite_path))
			iterator += 1


func update_UI() -> void:
	$Panel/VBoxContainer/MissionTitle.set_text(mission.title)
	$Panel/VBoxContainer/EncounterTitle.set_text(mission.encounters[encounter_counter].title)
	$Panel/VBoxContainer/Card/CardTitle.set_text(mission.encounters[encounter_counter].cards[card_counter].title)
	$Panel/VBoxContainer/Card/CardDescription.set_text(mission.encounters[encounter_counter].cards[card_counter].description)
	var battle_count_text = "Battle Count: " + str(battle_counter)
	$Panel/VBoxContainer/BattleCount.set_text(battle_count_text)
	var soldier_count_text = "SOLDIER COUNT: " + str(player.soldier_count)
	$Panel/VBoxContainer/SoldierCount.set_text(soldier_count_text)
	
	# Update card icons.
	var icons: Array = get_tree().get_nodes_in_group("Icons")
	## Turn off all the icons.
	for icon in icons:
		icon.set_visible(false)
	## Turn on and set the card icons.
	var card_icons: Dictionary = mission.encounters[encounter_counter].cards[card_counter].icons
	var iterator = 0
	# Iterate for each icon.
	for icon in card_icons:
		# Iterate for the quantity of icons.
		for quantity in card_icons[icon]:
			icons[iterator].set_visible(true)
			icons[iterator].set_modulate(icon.color)
			icons[iterator].set_texture(load(icon.sprite_path))
			iterator += 1

func _on_FightButton_pressed() -> void:
	var success : bool = combat_engine.card_vs_unit(mission.encounters[encounter_counter].cards[card_counter], player)
	
	if success:
		print("SUCCESS!")
	else:
		print("Failure.")
		player.soldier_count -= 1
		print_soldier_count()
	
	card_counter += 1
	battle_counter += 1
	
	check_player()
	check_progress()
	
	update_log(success, mission_counter, encounter_counter, card_counter)
	update_UI()


func update_log(battle_succes: bool, mission_count: int, encounter_count: int, card_count: int) -> void:
	var log_text: String = $Panel/VBoxContainer/Control/Log.get_text()
	var new_text : String
	if battle_succes:
		new_text = "> M" + str(mission_count) + "|Enc " + str(encounter_count + 1) + "/Card " + str(card_count + 1) + ": Success!"
	else:
		new_text = "> M" + str(mission_count) + "|Enc " + str(encounter_count + 1) + "/Card " + str(card_count + 1) + ": Failure. 1 soldier lost."
	
	log_text = new_text + "\n" + log_text
	$Panel/VBoxContainer/Control/Log.set_text(log_text)


func check_player() -> void:
	if player.soldier_count <= 0:
		print("YOU HAVE LOST.")
		print_soldier_count()
		get_tree().change_scene("res://GameOver.tscn")
		Global.game_state = "DEFEAT"


func check_progress() -> void:
	if card_counter >= mission.encounters[encounter_counter].cards.size():
		card_counter = 0
		encounter_counter += 1
	
	if encounter_counter >= mission.encounters.size():
		$Panel/VBoxContainer/FightButton.set_disabled(true)
		print("YOU HAVE WON.")
		print_soldier_count()
		get_tree().change_scene("res://GameOver.tscn")
		encounter_counter = 0
		Global.game_state = "VICTORY"


func print_soldier_count() -> void:
	print("Soldiers remaining: " + str(player.soldier_count))
