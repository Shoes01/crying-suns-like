class_name CombatEngine
extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func card_vs_unit(card, unit) -> bool:
	var success : bool = true
	
	for icon in card.icons:
		# Check to see if the unit has this icon.
		if unit.icons.has(icon):
			# Check to see if the unit has at least as many icons.
			if unit.icons[icon] > card.icons[icon]:
				success = true
			else:
				success = false
		else:
			success = false
	
	return success
