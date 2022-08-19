extends Node2D


func _ready() -> void:
	
	var mission = preload("res://missions/NewMission.gd").new()
	var player = preload("res://Player.gd").new()
	
	print(mission.title.to_upper())
	print("Soldier count: " + str(player.soldier_count))
	for encounter in mission.encounters:
		print("- " + encounter.title.to_upper())
		for card in encounter.cards:
			print("-- " + card.title)
			if randf() > 0.50:
				print("--- Success!")
			else:
				player.soldier_count -= 1
				print("--- Casualty taken. Soldiers left: " + str(player.soldier_count))
				if player.is_dead():
					break
		
		if player.is_dead():
			break
		else:
			print("- Encounter successful!")
	
	if player.is_dead():
		print("Mission failed.")
	else:
		print("Mission successful!!")
	
	print("Soldiers remaining: " + str(player.soldier_count))
