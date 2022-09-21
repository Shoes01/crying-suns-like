class_name Player
extends Node

var soldier_count = 5
var loot = 0

# Icons.
# I am putting this here until I create actual Units.
var open_fire_icon = load("res://icons/OpenFireIcon.gd") # WAIT is this still being used?
var take_cover_icon = load("res://icons/TakeCoverIcon.gd")

# Strategies.
# Same. Or not. Maybe it's not necessary.

var icons = {Icons.open_fire: 2, Icons.take_cover: 1}
var strategies = {Strategies.starter: 1}


func _ready() -> void:
	print("Player ready.")


func _test() -> void:
	print("TESTESTSET")


func is_dead() -> bool:
	if soldier_count <= 0: 
		return true
	return false
