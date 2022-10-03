# AUTOLOADED.
extends Node


var open_fire: Node
var take_cover: Node


func _init() -> void:
	open_fire = load("res://data/icons/OpenFireIcon.gd").new()
	take_cover = load("res://data/icons/TakeCoverIcon.gd").new()
