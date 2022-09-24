class_name MissionGenerator
extends Node


func generate(mission: Mission) -> Array:
	var results := []
	
	var iter = 0
	for encounter in mission.encounters:
		iter += 1
		var new_node = load("res://UI/IconInteractor.gd").new(encounter.color)
		new_node.set_texture(load(encounter.sprite_path))
		new_node.set_position(Vector2(200 + 300*iter, -100 + 150*iter))
		new_node.set_scale(Vector2(0.5, 0.5))
		new_node.encounter_data = encounter
		results.append(new_node)
	
	return results

