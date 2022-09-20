extends Node2D

@onready var idle_button = get_node("Panel/VBoxContainer/HBoxContainer/SATCOM/IdleButton")
@onready var scan_button = get_node("Panel/VBoxContainer/HBoxContainer/SATCOM/ScanButton")
@onready var rest_button = get_node("Panel/VBoxContainer/HBoxContainer/XCOM/RestButton")
@onready var embark_button = get_node("Panel/VBoxContainer/HBoxContainer/XCOM/EmbarkButton")
@onready var action_button = get_node("Panel/VBoxContainer/ActionButton")
@onready var confirm_button = get_node("Panel/VBoxContainer/ConfirmButton")
@onready var turn_counter = get_node("Panel/VBoxContainer/TurnCounter")

var is_mission_ready := false
var mission_embarked_this_turn := false
var turn : int = Global.turn_count

var SATCOM_buttons : ButtonGroup = ButtonGroup.new()
var XCOM_buttons : ButtonGroup = ButtonGroup.new()


func _ready() -> void:
	# SATCOM buttons.
	idle_button.set_button_group(SATCOM_buttons)
	scan_button.set_button_group(SATCOM_buttons)
	# XCOM buttons.
	rest_button.set_button_group(XCOM_buttons)
	embark_button.set_button_group(XCOM_buttons)


func _process(delta: float) -> void:
	if idle_button.is_pressed():
		idle_button.set_text("Idling...")
	else:
		idle_button.set_text("Idle.")
	
	if mission_embarked_this_turn:
		# Is disabled if a mission was done.
		scan_button.set_disabled(true)
		scan_button.set_pressed(false)
		# Also disable all XCOM buttons.
		for button in XCOM_buttons.get_buttons():
			button.set_disabled(true)
	elif is_mission_ready:
		# Is disabled if there is a mission.
		scan_button.set_disabled(true)
		scan_button.set_pressed(false)
	
	if scan_button.is_pressed():
		scan_button.set_text("Scanning...")
	elif is_mission_ready:
		scan_button.set_text("Mission Found!")
	else:
		scan_button.set_text("Scan for new mission.")
	
	if rest_button.is_pressed():
		rest_button.set_text("Resting...")
	else:
		rest_button.set_text("Rest.")
	
	if embark_button.is_pressed():
		embark_button.set_text("Preparing to embark...")
		confirm_button.set_visible(true)
	else:
		embark_button.set_text("Embark on new mission.")
		confirm_button.set_visible(false)
	
	
	embark_button.set_disabled(!is_mission_ready) # Is disabled if there is no mission.
	turn_counter.set_text("Turn: " + str(turn))
	

func _on_idle_button_pressed():
	pass


func _on_scan_button_pressed():
	pass # Replace with function body.


func _on_embark_button_pressed():
	pass # Replace with function body.


func _on_action_button_pressed():
	mission_embarked_this_turn = false
	
	if scan_button.is_pressed():
		is_mission_ready = true
	else:
		is_mission_ready = false
	
	for button in SATCOM_buttons.get_buttons():
		button.set_pressed(false)
		button.set_disabled(false)
	for button in XCOM_buttons.get_buttons():
		button.set_pressed(false)
		button.set_disabled(false)
	
	turn += 1


func _on_rest_button_pressed():
	pass # Replace with function body.


func _on_confirm_button_pressed():
	is_mission_ready = false
	mission_embarked_this_turn = true
	embark_button.set_pressed(false)
	
	Global.turn_count = turn
	get_tree().change_scene_to_file("res://Battlescape.tscn")
