extends Node2D

var mission_counter := 1
var encounter_counter := 0
var card_counter := 0
var battle_counter := 0

var mission = preload("res://missions/NewMission.gd").new()
var player = preload("res://Player.gd").new()
var combat_engine = preload("res://CombatEngine.gd").new()

@onready var soldier_list = $PlayerPanel/VBoxContainer/UnitPanel/VBoxContainer/VBoxContainer/SoldierList
@onready var icon_list = $PlayerPanel/VBoxContainer/UnitPanel/VBoxContainer/VBoxContainer/IconList

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
	var soldier_count_text = "SOLDIER COUNT: " + str(player.soldier_count) + " | LOOT " + str(player.loot)
	$Panel/VBoxContainer/SoldierCount.set_text(soldier_count_text)
	
	############# OLD ##########################
	# Update card icons.
	var icons: Array = get_tree().get_nodes_in_group("Icons")
	## Turn off all the icons.
	for icon in icons:
		icon.set_visible(false)
	## Turn on and set the card icons.
	var encounter = mission.encounters[encounter_counter]
	var card = encounter.cards[card_counter]
	var card_icons: Dictionary = card.icons
	var iterator = 0
	# Iterate for each icon.
	for icon in card_icons:
		# Iterate for the quantity of icons.
		for quantity in card_icons[icon]:
			icons[iterator].set_visible(true)
			icons[iterator].set_modulate(icon.color)
			icons[iterator].set_texture(load(icon.sprite_path))
			iterator += 1
	
	##########################################################
	# NEW: Populate card icons.
	## Clear the list.
	var card_icon_area = $MissionPanel/VBoxContainer/EncounterPanel/VBoxContainer/CardPanel/VBoxContainer
	for parent in card_icon_area.get_children():
		for child in parent.get_children():
			child.queue_free()
	
	var col := 1
	var current_card = mission.encounters[encounter_counter].cards[card_counter]
	
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
	
	
	# NEW: Populate the soldier list with the unit's soldiers.
	## CLear the list.
	soldier_list.clear()
	## Populate the list with soldiers.
	for n in player.soldier_count:
		# ISSUE : I have to add the thing to the list..
		var tex = Texture2D.new()
		var icon_sprite = load("res://icon.png")
		#print(icon_sprite)
		#tex.set_texture(load("res://icon.png"))
		#tex.set_modulate(Color("green"))
		var soldier_name = "Soldier #" + str(n+1)
		soldier_list.add_item(soldier_name, icon_sprite)
	
	icon_list.clear()
	for icon in player.icons:
		for n in player.icons[icon]:
			var new_icon = load(icon.sprite_path)
			icon_list.add_icon_item(new_icon)


func _on_FightButton_pressed() -> void:
	var success : bool = combat_engine.card_vs_unit(mission.encounters[encounter_counter].cards[card_counter], player)
	
	card_counter += 1
	battle_counter += 1
	
	check_player()
	check_progress()
	
	update_log(success, mission_counter, encounter_counter, card_counter)
	update_UI()
	update_player_panel()


func update_log(battle_succes: bool, mission_count: int, encounter_count: int, card_count: int) -> void:
	var log = $MissionPanel/VBoxContainer/LogScroll/LogText
	var log_text = log.get_text()
	var new_text : String = ""
	# Timestamp.
	new_text += "[" + str(battle_counter) + "]"
	# Encounter.
	new_text += "[Enc_" + str(encounter_count) + "]"
	# Card.
	new_text += "[Card_" + str(card_count) + "] "
	# Success message.
	if battle_succes:
		new_text += "Success!"
	else:
		new_text += "Failure."
	# Update log.
	log_text = new_text + "\n" + log_text
	log.set_text(log_text)


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


func _on_draw_button_pressed():
	_on_FightButton_pressed()


func update_player_panel() -> void:
	var data = $PlayerPanel/VBoxContainer/Data
	data.set_text("Collected loot: " + str(player.loot))
