# AUTOLOADED.
extends Node


var starter: Node
var waiting: Node


func _init() -> void:
	starter = load("res://data/strategies/StarterStrategy.gd").new()
	waiting = load("res://data/strategies/WaitStrategy.gd").new()
