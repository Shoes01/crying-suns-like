class_name IconButton
extends TextureButton


signal clicked

var color : Color
var is_clicked : bool = false
var encounter_data : Encounter


func _init(base_sprite_path := "res://icon.png", base_color := Color("white")) -> void:
	color = base_color
	set_normal_texture(load(base_sprite_path))


func _ready() -> void:
	connect("gui_input", Callable(self, "_on_texture_rect_gui_input"))
	connect("mouse_entered", Callable(self, "_on_texture_rect_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_texture_rect_mouse_exited"))
	
	set_modulate(Color(color))


func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			is_clicked = !is_clicked # toggle clicked state
			if is_clicked: set_modulate(Color("green"))
			else: set_modulate(Color("yellow"))
			clicked.emit()


func _on_texture_rect_mouse_entered() -> void:
	if !is_clicked:
		set_modulate(Color("yellow"))


func _on_texture_rect_mouse_exited() -> void:
	if !is_clicked:
		set_modulate(Color(color))

