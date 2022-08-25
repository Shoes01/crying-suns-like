class_name Player
extends Node

var soldier_count = 5
var loot = 0

# Icons.
# I am putting this here until I create actual Units.
var open_fire_icon = preload("res://icons/OpenFireIcon.gd")
var take_cover_icon = preload("res://icons/TakeCoverIcon.gd")

var icons = {Icons.open_fire: 2, Icons.take_cover: 1}

func _ready() -> void:
	print("Player ready.")


func is_dead() -> bool:
	if soldier_count <= 0: 
		return true
	return false
