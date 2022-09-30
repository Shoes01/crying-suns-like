class_name IconButton
extends TextureButton

var color : Color
var encounter_data : Encounter


func _init(base_sprite_path := "res://icon.png", base_color := Color("white")) -> void:
	color = base_color
	set_normal_texture(load(base_sprite_path))


func _ready() -> void:
	set_modulate(color)
	set_toggle_mode(true)


func _process(delta : float) -> void:
	if is_pressed():
		set_modulate(Color("green"))
	elif is_hovered():
		set_modulate(Color("yellow"))
	else:
		set_modulate(color)

