extends Strategy


func _init() -> void:
	sprite_path = "res://icon.png"
	title = "Wait"
	description = "Wait a bit. Take a breather."
	color = Color("khaki")
	bonuses = {} # Don't know what this will be yet.
	cards = [bonus_card.new(), bonus_card.new()]
