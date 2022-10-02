extends Node


var starter: Node
var waiting: Node


func _init() -> void:
	starter = load("res://strategies/StarterStrategy.gd").new()
	waiting = load("res://strategies/WaitStrategy.gd").new()
