class_name Player
extends Node

var soldier_count = 6
var loot = 0

var icons = {Icons.open_fire: 4, Icons.take_cover: 4}
var strategies = {Strategies.waiting: 1, Strategies.starter: 1}


func _ready() -> void:
	print("Player ready.")


func _test() -> void:
	print("TESTESTSET")


func is_dead() -> bool:
	if soldier_count <= 0: 
		return true
	return false
