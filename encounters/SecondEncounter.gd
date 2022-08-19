class_name SecondEncounter
extends Encounter

func _init() -> void:
	title = "Second Encounter"
	description = "This is the second encounter."
	cards = [attack_card.new(), defense_card.new(), defense_card.new()]
