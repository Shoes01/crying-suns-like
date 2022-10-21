extends Node


# Helper resouces.
var mission_generator: Resource = load("res://battlescape/MissionGenerator.gd").new()
# Button groups.
var encounter_buttons := ButtonGroup.new()
var unit_icon_buttons := ButtonGroup.new()


func _ready() -> void:
	# Mapgen.
	var mission: Mission = load("res://data/missions/NewMission.gd").new() 	# PLACEHOLDER until battlescape etc.
	var children: Array
	children = mission_generator.generate(mission)
	for child in children:
		child.set_button_group(encounter_buttons)
		get_node("BoardLayer/BoardArea").add_child(child)
		# These nodes have buttons that can be clicked.
		var callable := Callable(self, "_on_encounter_pressed")
		child.pressed.connect(callable.bind(child.encounter_data))
	# Initiate PlayerPanel.
	var player: Player = load("res://data/Player.gd").new()
	add_units(player.units)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		for button in encounter_buttons.get_buttons():
			button.set_pressed(false)
		for button in unit_icon_buttons.get_buttons():
			button.set_pressed(false)


func _on_encounter_pressed(value) -> void:
	print("Encounter clicked!")
	print(value)


func _on_unit_icon_buttons_pressed(value) -> void:
	print("Icon pressed: ", str(value.title))


func add_units(units: Array) -> void:
	for unit in units:
		add_unit(unit)


func add_unit(unit: Unit) -> void:
	var unit_node: Node = load("res://battlescape/UI/NewUnitPanel.tscn").instantiate()
	
	var callable := Callable(self, "_on_unit_icon_buttons_pressed")
	unit_node.prepare(unit, callable, unit_icon_buttons)
	#unit_node.size_flags_vertical = 3
	get_node("MenuLayer/PlayerPanel/ScrollContainer/VBoxContainer").add_child(unit_node)



