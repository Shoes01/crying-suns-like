extends Panel


signal strategy_chosen(strategy)

var all_icons := ButtonGroup.new()


func update_unit(event: Dictionary) -> void:
	var player: Player
	if event.has("player_hack"):
		player = event["player_hack"]
	else:
		return
	# Populate the unit panel with the soldiers and icons.
	## Clear the lists.
	var soldier_area := $VBoxContainer/VBoxContainer/SoldierArea
	for parent in soldier_area.get_children():
		for child in parent.get_children():
			child.queue_free()
	var icon_area := $VBoxContainer/VBoxContainer/IconArea
	for parent in icon_area.get_children():
		for child in parent.get_children():
			child.queue_free()
	var strategy_area := $VBoxContainer/VBoxContainer/StrategyArea
	for parent in strategy_area.get_children():
		for child in parent.get_children():
			child.queue_free()
		
	var col := 1
	var current_unit := player # PLACEHOLDER until I have more than one unit
	# Populate soldiers.
	col = 0
	for n in current_unit.soldier_count:
		col += 1
		var soldier_color := Color("medium sea green")
		var texture_rect := IconButton.new("res://icon.png", soldier_color)
		texture_rect.set_button_group(all_icons)
		if col <= 5:
			var row := soldier_area.get_node("SoldierRow1")
			row.set_size(Vector2(350, 64))
			row.add_child(texture_rect)
		elif col <=10:
			var row := soldier_area.get_node("SoldierRow2")
			row.set_size(Vector2(350, 64))
			var panel_size := get_size()
			set_size(panel_size + Vector2(65, 0))
			row.add_child(texture_rect)
		else:
			print("TOO MANY SOLDIERS!!!")
			var row := soldier_area.get_node("SoldierRow2")
			row.add_child(texture_rect)
	# Populate icons.
	col = 0
	for icon in player.icons:
		for quantity in player.icons[icon]:
			col += 1
			var texture_rect := IconButton.new(icon.sprite_path, icon.color)
			texture_rect.set_button_group(all_icons)
			if col <= 5:
				var row := icon_area.get_node("IconRow1")
				row.set_size(Vector2(350, 64))
				row.add_child(texture_rect)
			elif col <=10:
				var row := icon_area.get_node("IconRow2")
				row.set_size(Vector2(350, 64))
				row.add_child(texture_rect)
				var panel_size := get_size()
				set_size(panel_size + Vector2(65, 0))
			else:
				print("TOO MANY ICONS!!!")
				var row := icon_area.get_node("IconRow2")
				row.add_child(texture_rect)
	# Populate strategies.
	col = 0
	for strategy in player.strategies:
		for quantity in player.strategies[strategy]:
			col += 1
			var texture_rect := IconButton.new(strategy.sprite_path, strategy.color)
			texture_rect.connect("pressed", Callable(self, "_emit_strat_signal").bind(strategy))
			texture_rect.set_button_group(all_icons)
			if col <= 5:
				var row := strategy_area.get_node("StrategyRow1")
				row.set_size(Vector2(350, 64))
				row.add_child(texture_rect)
			elif col <=10:
				var row := strategy_area.get_node("StrategyRow2")
				row.set_size(Vector2(350, 64))
				var panel_size := get_size()
				set_size(panel_size + Vector2(65, 0))
				row.add_child(texture_rect)
			else:
				print("TOO MANY STRATEGIES!!!")
				var row := strategy_area.get_node("StrategyRow2")
				row.add_child(texture_rect)


func _emit_strat_signal(strategy: Strategy) -> void:
	strategy_chosen.emit(strategy)
