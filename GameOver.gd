extends Node2D


@onready var label := get_node("Panel/Label")


func _ready() -> void:
	if Global.game_state == "VICTORY":
		label.set_text("You are winner.")
	elif Global.game_state == "DEFEAT":
		label.set_text("You are loser.")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://NewGame.tscn")
	Global.game_state = "NEW_GAME"


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://geoscape/Geoscape.tscn")
	Global.game_state = "GAME"
