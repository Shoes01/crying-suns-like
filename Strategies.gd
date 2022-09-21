extends Node


var starter : Node


func _init() -> void:
	starter = load("res://strategies/StarterStrategy.gd").new()
