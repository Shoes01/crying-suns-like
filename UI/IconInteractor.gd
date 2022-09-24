class_name IconInteractor
extends TextureRect


signal clicked

var color := Color("white")
var is_clicked : bool = false
var encounter_data : Encounter


func _init(base_color: Color) -> void:
		color = base_color


func _ready() -> void:
	connect("gui_input", Callable(self, "_on_texture_rect_gui_input"))
	connect("mouse_entered", Callable(self, "_on_texture_rect_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_texture_rect_mouse_exited"))
	set_modulate(Color(color))


func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			set_modulate(Color("green"))
			is_clicked = !is_clicked # toggle clicked state
			clicked.emit()


func _on_texture_rect_mouse_entered() -> void:
	if !is_clicked:
		set_modulate(Color("yellow"))


func _on_texture_rect_mouse_exited() -> void:
	if !is_clicked:
		set_modulate(Color(color))

