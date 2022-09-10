class_name CombatEngine
extends Node


func _ready() -> void:
	print(name, " is ready.")


func card_vs_unit(card, unit) -> bool:
	var success : bool = true
	# Loop through all the icons on the card.
	for icon in card.icons:
		# Establish how many of this icon are on the card and on the unit.
		var number_of_card_icons = card.icons[icon]
		var number_of_unit_icons := 0
		if unit.icons.has(icon):
			number_of_unit_icons = unit.icons[icon]
		var icon_difference = number_of_card_icons - number_of_unit_icons
		# The card has more icons.
		if icon_difference > 0:
			success = false
			# The unit wins for each icon they have.
			# And they lose the difference.
			for n in number_of_unit_icons:
				battle_rewards(unit, icon)
			for n in icon_difference:
				battle_penalties(unit, icon)
		# The unit has at least as many icons as the card.
		else:
			# The unit wins as many icons as there are on the card.
			# There are no losses.
			for n in number_of_card_icons:
				battle_rewards(unit, icon)
		
	return success


func battle_rewards(unit, icon) -> void:
	for key in icon.rewards:
		match key:
			"loot": 
				unit.loot += icon.rewards["loot"]
				print("Awarded loot: " + str(icon.rewards["loot"]))


func battle_penalties(unit, icon) -> void:
	for key in icon.penalties:
		match key:
			"soldier_damage": 
				unit.soldier_count -= icon.penalties["soldier_damage"]
				print("Soldiers damage: " + str(icon.penalties["soldier_damage"]))
