extends Icon


func _init() -> void:
	sprite_path = "res://icon.png"
	title = "Take Cover!"
	description = "Take cover from enemy fire."
	color = Color("blue")
	penalties = {"soldier_damage": 1}
