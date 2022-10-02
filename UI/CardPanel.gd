class_name CardPanel
extends Panel


@onready var card_title := $VBoxContainer/CardTitle
@onready var card_icon_area := $VBoxContainer/Control


func update_card(event: Dictionary) -> void:
	if event.has("new_card"):
		_update_card_panel(event["new_card"])


func _update_card_panel(card: Card) -> void:
	# Update name.
	card_title.set_text(card.title)
	# Populate card icons.
	## Clear the list.
	for parent in card_icon_area.get_children():
		for child in parent.get_children():
			child.queue_free()
	## Prepare new list.
	var col := 0
	for icon in card.icons:
		for quantity in card.icons[icon]:
			col += 1
			var texture_rect := TextureRect.new()
			texture_rect.set_texture(load(icon.sprite_path))
			texture_rect.set_modulate(icon.color)
			if col <= 5:
				var row := card_icon_area.get_node("Row1")
				row.add_child(texture_rect)
			elif col <=10:
				var row := card_icon_area.get_node("Row2")
				row.add_child(texture_rect)
			else:
				print("TOO MANY ICONS!!!")
				var row := card_icon_area.get_node("Row2")
				row.add_child(texture_rect)
