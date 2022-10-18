extends Node


@onready var mission_UI := $MissionPanel
@onready var player_UI := $PlayerPanel
@onready var hud_UI := $HUDPanel

var mission_logic: MissionLogic = load("res://battlescape/MissionLogic.gd").new()


func _ready() -> void:
	# Connect signals.
	## UI to Logic signals.
	mission_UI.encounter.draw_button_pressed.connect(Callable(mission_logic, "_on_draw_button_pressed"))
	player_UI.unit.strategy_chosen.connect(Callable(mission_logic, "_on_strategy_chosen"))
	get_node("HUDPanel/VBoxContainer/EngageButton").pressed.connect(Callable(mission_logic, "_on_engage_pressed"))
	### There is another signal further that connects the Encounters to MissionLogic.
	## Logic to UI signals.
	mission_logic.UI_updated.connect(Callable(mission_UI, "_on_UI_updated"))
	mission_logic.UI_updated.connect(Callable(player_UI, "_on_UI_updated"))
	mission_logic.UI_updated.connect(Callable(self, "_on_UI_updated")) # PLACEHOLDER kind of until MissionArea is more developped.
	
	# Send data to MissionLogic.
	var player: Player = load("res://data/Player.gd").new() 					# PLACEHOLDER until the Battlescape can be properly invoked by the Geoscape.
	mission_logic.prepare_player(player)
	player_UI.unit.update_unit({"player_hack": player}) # PLACERHOLDER until the player has proper units.
	
	# Mapgen.
	var mission: Mission = load("res://data/missions/NewMission.gd").new() 	# PLACEHOLDER until battlescape etc.
	var children: Array
	children = get_node("Tools/MissionGenerator").generate(mission)
	for child in children:
		get_node("MissionArea").add_child(child)
		# Connect Encounter and MissionLogic.
		var callable := Callable(mission_logic, "_on_encounter_pressed")
		child.pressed.connect(callable.bind(child.encounter_data))


func _on_UI_updated(event: Dictionary) -> void:
	# Check if an Encounter has been beaten.
	if event.has("encounter_was_beaten"): 
		print("Encounter beaten!")
		for child in get_node("MissionArea").get_children():
			if child.encounter_data.title == event["encounter_was_beaten"].title:
				child.set_disabled(true)
		
