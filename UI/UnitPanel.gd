extends Panel


func update_unit(event: Dictionary) -> void:
	var player
	if event.has("player_hack"):
		player = event["player_hack"]
	else:
		return
	# Populate the unit panel with the soldiers and icons.
	## Clear the lists.
	var soldier_area = $VBoxContainer/VBoxContainer/SoldierArea
	for parent in soldier_area.get_children():
		for child in parent.get_children():
			child.queue_free()
	var icon_area = $VBoxContainer/VBoxContainer/IconArea
	for parent in icon_area.get_children():
		for child in parent.get_children():
			child.queue_free()
	var strategy_area = $VBoxContainer/VBoxContainer/StrategyArea
	for parent in strategy_area.get_children():
		for child in parent.get_children():
			child.queue_free()
		
	var col = 1
	var current_unit = player # PLACEHOLDER until I have more than one unit
	# Populate soldiers.
	col = 1
	for n in current_unit.soldier_count:
		var texture_rect := TextureRect.new()
		texture_rect.set_texture(load("res://icon.png"))
		texture_rect.set_modulate(Color("green"))
		if col <= 5:
			var row = soldier_area.get_node("SoldierRow1")
			row.add_child(texture_rect)
		elif col <=10:
			var row = soldier_area.get_node("SoldierRow2")
			row.add_child(texture_rect)
		else:
			print("TOO MANY SOLDIERS!!!")
			var row = soldier_area.get_node("SoldierRow2")
			row.add_child(texture_rect)
	# Populate icons.
	col = 1
	for icon in player.icons:
		for quantity in player.icons[icon]:
			var texture_rect := TextureRect.new()
			texture_rect.set_texture(load(icon.sprite_path))
			texture_rect.set_modulate(icon.color)
			if col <= 5:
				var row = icon_area.get_node("IconRow1")
				row.add_child(texture_rect)
			elif col <=10:
				var row = icon_area.get_node("IconRow2")
				row.add_child(texture_rect)
			else:
				print("TOO MANY ICONS!!!")
				var row = icon_area.get_node("IconRow2")
				row.add_child(texture_rect)
	# Populate strategies.
	col = 1
	for strategy in player.strategies:
		for quantity in player.strategies[strategy]:
			var texture_rect := TextureRect.new()
			texture_rect.set_texture(load(strategy.sprite_path))
			texture_rect.set_modulate(strategy.color)
			if col <= 5:
				var row = strategy_area.get_node("StrategyRow1")
				row.add_child(texture_rect)
			elif col <=10:
				var row = strategy_area.get_node("StrategyRow2")
				row.add_child(texture_rect)
			else:
				print("TOO MANY STRATEGIES!!!")
				var row = strategy_area.get_node("StrategyRow2")
				row.add_child(texture_rect)
