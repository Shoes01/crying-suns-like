class_name Player
extends Node

var soldier_count = 5
var loot = 0

var icons = {Icons.open_fire: 2, Icons.take_cover: 1}
var strategies = {Strategies.waiting: 1, Strategies.starter: 1}


func _ready() -> void:
	print("Player ready.")


func _test() -> void:
	print("TESTESTSET")


func is_dead() -> bool:
	if soldier_count <= 0: 
		return true
	return false
