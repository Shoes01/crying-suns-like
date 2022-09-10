class_name Mission
extends Node

var title := "base mission title"
var description := "base mission description"
var encounters : Array
var was_attempted := false
var was_succesful := false

var first_encounter = load("res://encounters/FirstEncounter.gd")
var second_encounter = load("res://encounters/SecondEncounter.gd")


func set_success(value: bool) -> void:
	was_succesful = value


func mark_as_attempted() -> void:
	was_attempted = true
