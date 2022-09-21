class_name IconInteractor
extends Node2D


func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			set_modulate(Color("green"))


func _on_texture_rect_mouse_entered() -> void:
	set_modulate(Color("yellow"))


func _on_texture_rect_mouse_exited() -> void:
	set_modulate(Color("white"))
