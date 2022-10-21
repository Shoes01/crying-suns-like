extends PanelContainer


func _populate_grid(type:String, unit: Unit, callable: Callable, button_group: ButtonGroup) -> void:
	var dict : Dictionary
	var node_path : String
	
	match type:
		"soldiers":
			dict = unit.soldiers
			node_path = "VBoxContainer/SoldiersGrid"
		"icons":
			dict = unit.icons
			node_path = "VBoxContainer/IconsGrid"
		"strategies":
			dict = unit.strategies
			node_path = "VBoxContainer/StrategiesGrid"
	
	for key in dict:
		# key : Node
		var quantity: int = dict[key]
		for n in quantity:
			var new_icon := IconButton.new(key.sprite_path, key.color)
			new_icon.set_button_group(button_group)
			new_icon.pressed.connect(callable.bind(key)) # OPTIONAL : I can bind it.
			get_node(node_path).add_child(new_icon)


func prepare(unit: Unit, callable: Callable, button_group: ButtonGroup) -> void:
	print(unit)
	var soldiers: Dictionary = unit.soldiers
	var icons: Dictionary = unit.icons
	var strategies: Dictionary = unit.strategies
	
	_populate_grid("soldiers", unit, callable, button_group)
	_populate_grid("icons", unit, callable, button_group)
	_populate_grid("strategies", unit, callable, button_group)
