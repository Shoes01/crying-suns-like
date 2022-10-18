class_name Unit
extends Resource


var soldiers: Dictionary
var icons: Dictionary
var strategies: Dictionary


func _init(soldiers_init: Dictionary, icons_init: Dictionary, strategies_init: Dictionary) -> void:
	soldiers = soldiers_init
	icons = icons_init
	strategies = strategies_init
