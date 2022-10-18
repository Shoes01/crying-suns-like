extends Panel


func prepare(unit: Unit, callable: Callable, button_group: ButtonGroup) -> void:
	print(unit)
	var soldiers: Dictionary = unit.soldiers
	var icons: Dictionary = unit.icons
	var strategies: Dictionary = unit.strategies
	
	# Populate Soldiers grid.
	for key in soldiers:
		var soldier: Node = key
		var quantity: int = soldiers[key]
		
		for n in quantity:
			var new_icon := IconButton.new(soldier.sprite_path, soldier.color)
			new_icon.set_button_group(button_group)
			new_icon.pressed.connect(callable.bind(soldier)) # OPTIONAL : I can bind it.
			get_node("VBoxContainer/SoldiersGrid").add_child(new_icon)
	
	# Populate Icons grid.
	for key in icons:
		var icon: Node = key
		var quantity: int = icons[key]
		
		for n in quantity:
			var new_icon := IconButton.new(icon.sprite_path, icon.color)
			new_icon.set_button_group(button_group)
			new_icon.pressed.connect(callable.bind(icon)) # OPTIONAL : I can bind it.
			get_node("VBoxContainer/IconsGrid").add_child(new_icon)
	
	# Populate Strategies grid.
	for key in strategies:
		var strategy: Node = key
		var quantity: int = strategies[key]
		
		for n in quantity:
			var new_icon := IconButton.new(strategy.sprite_path, strategy.color)
			new_icon.set_button_group(button_group)
			new_icon.pressed.connect(callable.bind(strategy)) # OPTIONAL : I can bind it.
			get_node("VBoxContainer/StrategiesGrid").add_child(new_icon)
