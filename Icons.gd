extends Node


var open_fire : Node
var take_cover : Node


func _init() -> void:
	open_fire = preload("res://icons/OpenFireIcon.gd").new()
	take_cover = preload("res://icons/TakeCoverIcon.gd").new()
