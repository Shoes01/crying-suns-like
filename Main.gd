extends Node2D

@onready var mission_logic: Node = $MissionLogic
@onready var mission_UI: Node = $MissionPanel
@onready var player_UI: Node = $PlayerPanel
var mission : Mission
var player : Player

var local_state := "NO_STATE" # Gonna try this without the singleton.


func _ready() -> void:
	# Connect signals.
	mission_UI.encounter.draw_button_pressed.connect(Callable(mission_logic, "_on_draw_button_pressed"))
	mission_logic.UI_updated.connect(Callable(mission_UI, "_on_UI_updated"))
	mission_logic.UI_updated.connect(Callable(player_UI, "_on_UI_updated"))
	# Prepare new mission with required data.
	player = load("res://Player.gd").new() 				# PLACEHOLDER
	mission = load("res://missions/NewMission.gd").new() # PLACEHOLDER
	player_UI.unit.update_unit({"player_hack": player})
	mission_logic.prepare_mission(mission)
	mission_logic.prepare_player(player)

