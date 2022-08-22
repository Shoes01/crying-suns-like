extends Node2D

@onready var label = get_node("Panel/Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.game_state == "VICTORY":
		label.set_text("You are winner.")
	elif Global.game_state == "DEFEAT":
		label.set_text("You are loser.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene("res://NewGame.tscn")
	Global.game_state = "NEW_GAME"
