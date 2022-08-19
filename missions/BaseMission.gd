class_name Mission
extends Node

export var title = "base mission title"
export var description = "base mission description"
export var encounters : Array

var first_encounter = preload("res://encounters/FirstEncounter.gd")
var second_encounter = preload("res://encounters/SecondEncounter.gd")
