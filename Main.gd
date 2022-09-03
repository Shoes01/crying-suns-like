extends Node2D

@onready var mission_logic: Node = $MissionLogic
@onready var mission_UI: Node = $MissionPanel
@onready var player_UI: Node = $PlayerPanel
var mission : Mission
var player : Player

var local_state := "NO_STATE" # Gonna try this without the singleton.


func _init(new_mission : Mission, new_player : Player) -> void:
	# Initiate node with new mission data.
	mission = new_mission
	player = new_player
	
	# QUESTION : Do I need the mission and player vars? Can I init() mission_logic with this information?


func _ready() -> void:
	# Connect signals.
	mission_UI.encounter.draw_button_pressed.connect(Callable(mission_logic, "_on_draw_button_pressed"))
	mission_logic.UI_upated.connect(Callable(mission_UI, "_on_UI_updated"))
	mission_logic.UI_upated.connect(Callable(player_UI, "_on_UI_updated"))
	# Prepare new mission with required data.
	player = preload("res://Player.gd").new() 				# PLACEHOLDER
	mission = preload("res://missions/NewMission.gd").new() # PLACEHOLDER
	mission_logic.prepare_mission(mission)
	mission_logic.prepare_player(player)
