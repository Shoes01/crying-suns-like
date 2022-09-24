extends Strategy


func _init() -> void:
	sprite_path = "res://icon.png"
	title = "base strategy title"
	description = "base strategy description"
	color = Color("firebrick")
	bonuses = {} # Don't know what this will be yet.
	cards = [bonus_card.new()]
