class_name MissionGenerator
extends Node


var button_group := ButtonGroup.new()


func generate(mission: Mission) -> Array:
	var results := []
	
	var iter := 0
	for encounter in mission.encounters:
		iter += 1
		var new_node: IconButton = load("res://battlescape/UI/IconInteractor.gd").new(encounter.sprite_path, encounter.color)
		new_node.set_position(Vector2(200 + 300*iter, -100 + 150*iter))
		new_node.set_scale(Vector2(0.5, 0.5))
		new_node.encounter_data = encounter
		new_node.set_button_group(button_group)
		results.append(new_node)
	
	return results

