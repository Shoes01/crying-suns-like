class_name NewMission
extends Mission

func _init() -> void:
	title = "Test Mission"
	description = "This mission is just a test."
	encounters = [first_encounter.new(), second_encounter.new()]
