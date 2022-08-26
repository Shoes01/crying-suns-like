# Controls Mission logic.
extends Node2D


var battle_counter := 0
var card_counter := 0
var encounter_counter := 0
var mission_counter := 1

var combat_engine = preload("res://CombatEngine.gd").new()
var mission = preload("res://missions/NewMission.gd").new()
var player = preload("res://Player.gd").new()

@onready var soldier_list = $PlayerPanel/VBoxContainer/UnitPanel/VBoxContainer/VBoxContainer/SoldierList
@onready var icon_list = $PlayerPanel/VBoxContainer/UnitPanel/VBoxContainer/VBoxContainer/IconList


func _ready() -> void:
	update_UI("new_mission")


func update_UI(event: String) -> void:
	update_card_panel()
	update_unit_panel()
	update_player_panel()
	update_log(event)


func update_log(event: String) -> void:
	var log = $MissionPanel/VBoxContainer/LogScroll/LogText
	var log_text = log.get_text()
	var new_text : String = ""
	# In case of a new mission
	if event == "new_mission":
		log.set_text("NEW MISSION")
		return
	# Timestamp.
	new_text += "[" + str(battle_counter) + "]"
	# Encounter.
	new_text += "[Enc_" + str(encounter_counter) + "]"
	# Card.
	new_text += "[Card_" + str(card_counter) + "] "
	# Success message.
	if event == "win":
		new_text += "Success!"
	elif event == "loss":
		new_text += "Failure."
	# Update log.
	log_text = new_text + "\n" + log_text
	log.set_text(log_text)


func check_player() -> void:
	# Check if the player has any soldiers remaining.
	# NOTE: This will be replaced once units are a thing.
	if player.soldier_count <= 0:
		get_tree().change_scene("res://GameOver.tscn")
		Global.game_state = "DEFEAT"


func check_progress() -> void:
	# Check if the encounter is out of cards.
	if card_counter >= mission.encounters[encounter_counter].cards.size():
		card_counter = 0
		encounter_counter += 1
	# Check if the mission is out of encounters.
	if encounter_counter >= mission.encounters.size():
		get_tree().change_scene("res://GameOver.tscn")
		encounter_counter = 0
		Global.game_state = "VICTORY"


func _on_draw_button_pressed():
	# Determine the outcome of the card.
	var success : bool = combat_engine.card_vs_unit(mission.encounters[encounter_counter].cards[card_counter], player)
	# Crudge method of tracking progress.
	card_counter += 1
	battle_counter += 1
	# Update things.
	check_player()
	check_progress()
	# Communicate the event.
	var event := ""
	if success:
		event = "win"
	else:
		event = "loss"
	update_UI(event)


func update_player_panel() -> void:
	var data = $PlayerPanel/VBoxContainer/Data
	data.set_text("Collected loot: " + str(player.loot))


func update_unit_panel() -> void:
	# Populate the unit panel with the soldiers and icons.
	## Clear the list.
	var unit_area = $PlayerPanel/VBoxContainer/UnitPanel/VBoxContainer/VBoxContainer
	for parent in unit_area.get_children():
		for child in parent.get_children():
			child.queue_free()
	
	var col = 1
	var current_unit = player
	
	# Populate icons.
	for icon in player.icons:
		for quantity in player.icons[icon]:
			var texture_rect := TextureRect.new()
			texture_rect.set_texture(load(icon.sprite_path))
			texture_rect.set_modulate(icon.color)
			if col <= 5:
				var row = unit_area.get_node("IconRow1")
				row.add_child(texture_rect)
			elif col <=10:
				var row = unit_area.get_node("IconRow2")
				row.add_child(texture_rect)
			else:
				print("TOO MANY ICONS!!!")
				var row = unit_area.get_node("IconRow2")
				row.add_child(texture_rect)
	# Populate soldiers.
	col = 1
	for n in current_unit.soldier_count:
		var texture_rect := TextureRect.new()
		texture_rect.set_texture(load("res://icon.png"))
		texture_rect.set_modulate(Color("green"))
		if col <= 5:
			var row = unit_area.get_node("SoldierRow1")
			row.add_child(texture_rect)
		elif col <=10:
			var row = unit_area.get_node("SoldierRow2")
			row.add_child(texture_rect)
		else:
			print("TOO MANY SOLDIERS!!!")
			var row = unit_area.get_node("SoldierRow2")
			row.add_child(texture_rect)


func update_card_panel() -> void:
	var current_card = mission.encounters[encounter_counter].cards[card_counter]
	# Update name.
	var card_title = $MissionPanel/VBoxContainer/EncounterPanel/VBoxContainer/CardPanel/VBoxContainer/CardTitle
	card_title.set_text(current_card.title)
	# Populate card icons.
	var card_icon_area = $MissionPanel/VBoxContainer/EncounterPanel/VBoxContainer/CardPanel/VBoxContainer
	## Clear the list.
	for parent in card_icon_area.get_children():
		for child in parent.get_children():
			child.queue_free()
	## Prepare new list.
	var col := 1
	for icon in current_card.icons:
		for quantity in current_card.icons[icon]:
			var texture_rect := TextureRect.new()
			texture_rect.set_texture(load(icon.sprite_path))
			texture_rect.set_modulate(icon.color)
			if col <= 5:
				var row = card_icon_area.get_node("Row1")
				row.add_child(texture_rect)
			elif col <=10:
				var row = card_icon_area.get_node("Row2")
				row.add_child(texture_rect)
			else:
				print("TOO MANY ICONS!!!")
				var row = card_icon_area.get_node("Row2")
				row.add_child(texture_rect)
