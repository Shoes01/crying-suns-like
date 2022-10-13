class_name CombatEngine
extends Node


func build_deck(encounter: Encounter, strategy: Strategy) -> Array:
	# TODO:
	# Choose a subset of cards from encounter and strategy.
	# Size of subset dictated by encounter/strat
	# The encounter cards and strategy cards are mixed together, but the strategy cards should be drawn in order.
	## ie the first strategy card drawn is SomeStrat_1. The second is SomeStrat_2. 
	
	var deck: Array
	
	deck = encounter.cards + strategy.cards
	deck.shuffle()
	
	return deck


# PLACEHOLDER: unit does not have a proper type yet.
func card_vs_unit(card: Card, unit: Player) -> Dictionary:
	var results := {}
	# Loop through all the icons on the card.
	for icon in card.icons:
		# Establish how many of this icon are on the card and on the unit.
		var number_of_card_icons: int = card.icons[icon]
		var number_of_unit_icons := 0
		if unit.icons.has(icon):
			number_of_unit_icons = unit.icons[icon]
		var icon_difference := number_of_card_icons - number_of_unit_icons
		# The card has more icons.
		if icon_difference > 0:
			results["card_was_beaten"] = false #success = false
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
			results["card_was_beaten"] = true 
			for n in number_of_card_icons:
				battle_rewards(unit, icon)
		# Calculate how many icons were beaten.
		var number_of_icons_beaten := 0
		if number_of_card_icons > number_of_unit_icons:
			number_of_icons_beaten = number_of_unit_icons
		else:
			number_of_icons_beaten = number_of_card_icons
		results[icon] = number_of_icons_beaten
		
	return results


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
