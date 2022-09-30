extends Node


@onready var mission_logic: Node = $MissionLogic
@onready var mission_UI: Node = $MissionPanel
@onready var player_UI: Node = $PlayerPanel
@onready var hud_UI: Node = $HUDPanel


func _ready() -> void:
	# Connect signals.
	## UI to Logic signals.
	mission_UI.encounter.draw_button_pressed.connect(Callable(mission_logic, "_on_draw_button_pressed"))
	player_UI.unit.strategy_chosen.connect(Callable(mission_logic, "_on_strategy_chosen"))
	get_node("HUDPanel/VBoxContainer/EngageButton").pressed.connect(Callable(mission_logic, "_on_engage_pressed"))
	### There is another signal further down in the first-time stuff.
	## Logic to UI signals.
	mission_logic.UI_updated.connect(Callable(mission_UI, "_on_UI_updated"))
	mission_logic.UI_updated.connect(Callable(player_UI, "_on_UI_updated"))
	
	# Send data to MissionLogic.
	var player = load("res://Player.gd").new() 					# PLACEHOLDER until the Battlescape can be properly invoked by the Geoscape.
	var mission = load("res://missions/NewMission.gd").new() 	# PLACEHOLDER (ditto)
	mission_logic.prepare_player(player)
	
	# Prepare first-time stuff.
	## UI stuff.
	player_UI.unit.update_unit({"player_hack": player}) # PLACERHOLDER until the player has proper units.
	## Mapgen stuff.
	var children : Array
	children = get_node("Tools/MissionGenerator").generate(mission)
	for child in children:
		get_node("MissionArea").add_child(child)
		var callable = Callable(mission_logic, "_on_encounter_pressed")
		child.pressed.connect(callable.bind(child.encounter_data))

