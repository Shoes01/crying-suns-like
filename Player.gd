class_name Player
extends Node

var soldier_count = 5


func _ready() -> void:
	print("Player ready.")


func is_dead() -> bool:
	if soldier_count <= 0: 
		return true
	return false
