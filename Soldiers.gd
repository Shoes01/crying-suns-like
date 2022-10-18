# AUTOLOADED.
extends Node


var base_soldier: Node


func _init() -> void:
	base_soldier = load("res://data/soldiers/BaseSoldier.gd").new()
