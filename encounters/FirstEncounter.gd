class_name FirstEncounter
extends Encounter

func _init() -> void:
	title = "First Encounter"
	description = "This is the first encounter."
	cards = [attack_card.new(), attack_card.new(), defense_card.new()]
