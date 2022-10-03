class_name Encounter
extends Node

var title = "base encounter title"
var description = "base encounter description"
var cards : Array
var sprite_path := "res://icon.png"
var color := Color("white")
var was_attempted := false
var was_succesful := false

var attack_card := load("res://data/cards/AttackCard.gd")
var defense_card := load("res://data/cards/DefenseCard.gd")
var bonus_card := load("res://data/cards/BonusCard.gd")


func set_success(value: bool) -> void:
	was_succesful = value


func mark_as_attempted() -> void:
	was_attempted = true
