class_name MissionGenerator
extends Node


func generate(mission: Mission) -> Array:
	# 1) Receive mission data
	# 2) Create Encounter nodes to add to the 2D world
	### 2.1) Give these nodes the proper sprites and all that.
	### 2.2) Give them positions and stuff too I guess.
	# Q : Is there thing that can actually do that for me instead? A "master layout node" ?
	
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
