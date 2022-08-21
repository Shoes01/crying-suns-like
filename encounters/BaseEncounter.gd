class_name Encounter
extends Node

var title = "base encounter title"
var description = "base encounter description"
var cards : Array
var was_attempted := false
var was_succesful := false

var attack_card = preload("res://cards/AttackCard.gd")
var defense_card = preload("res://cards/DefenseCard.gd")


func set_success(value: bool) -> void:
	was_succesful = value


func mark_as_attempted() -> void:
	was_attempted = true
