class_name Encounter
extends Node

export var title = "base encounter title"
export var description = "base encounter description"
export var cards : Array
export var was_attempted := false
export var was_succesful := false

var attack_card = preload("res://cards/AttackCard.gd")
var defense_card = preload("res://cards/DefenseCard.gd")


func set_success(value: bool) -> void:
	was_succesful = value


func mark_as_attempted() -> void:
	was_attempted = true
