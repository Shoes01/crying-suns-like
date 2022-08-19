class_name Mission
extends Node

export var title := "base mission title"
export var description := "base mission description"
export var encounters : Array
export var was_attempted := false
export var was_succesful := false

var first_encounter = preload("res://encounters/FirstEncounter.gd")
var second_encounter = preload("res://encounters/SecondEncounter.gd")


func set_success(value: bool) -> void:
	was_succesful = value


func mark_as_attempted() -> void:
	was_attempted = true
