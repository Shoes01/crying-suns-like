extends Panel


func update_unit(event: Dictionary) -> void:
	var player = event["player_hack"]
	# Populate the unit panel with the soldiers and icons.
	## Clear the list.
	var unit_area = $PlayerPanel/VBoxContainer/UnitPanel/VBoxContainer/VBoxContainer
	for parent in unit_area.get_children():
		for child in parent.get_children():
			child.queue_free()
	
	var col = 1
	var current_unit = player
	
	# Populate icons.
	for icon in player.icons:
		for quantity in player.icons[icon]:
			var texture_rect := TextureRect.new()
			texture_rect.set_texture(load(icon.sprite_path))
			texture_rect.set_modulate(icon.color)
			if col <= 5:
				var row = unit_area.get_node("IconRow1")
				row.add_child(texture_rect)
			elif col <=10:
				var row = unit_area.get_node("IconRow2")
				row.add_child(texture_rect)
			else:
				print("TOO MANY ICONS!!!")
				var row = unit_area.get_node("IconRow2")
				row.add_child(texture_rect)
	# Populate soldiers.
	col = 1
	for n in current_unit.soldier_count:
		var texture_rect := TextureRect.new()
		texture_rect.set_texture(load("res://icon.png"))
		texture_rect.set_modulate(Color("green"))
		if col <= 5:
			var row = unit_area.get_node("SoldierRow1")
			row.add_child(texture_rect)
		elif col <=10:
			var row = unit_area.get_node("SoldierRow2")
			row.add_child(texture_rect)
		else:
			print("TOO MANY SOLDIERS!!!")
			var row = unit_area.get_node("SoldierRow2")
			row.add_child(texture_rect)
