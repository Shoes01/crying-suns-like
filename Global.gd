extends Node

var game_state : String
var turn_count : int

func _ready() -> void:
	game_state = "DEFAULT"
	turn_count = 0
