class_name Player
extends Resource


var loot: int
var units: Array


func _init() -> void:
	loot = 0
	# PLACEHOLDER CODE
	var unit_script: Resource = load("res://data/Unit.gd")
	var unit_icons := {
		Icons.take_cover : 3,
		Icons.open_fire : 3,
	}
	var unit_strategies := {
		Strategies.starter : 1,
		Strategies.waiting : 1,
	}
	var unit_soldiers := {
		Soldiers.base_soldier : 6,
	}
	
	var it := 0
	while it <= 2:
		it += 1
		var unit: Unit = unit_script.new(unit_soldiers, unit_icons, unit_strategies)
		units.append(unit)
