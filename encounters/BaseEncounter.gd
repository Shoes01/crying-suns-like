class_name Encounter
extends Node

export var title = "base encounter title"
export var description = "base encounter description"
export var cards : Array

var attack_card = preload("res://cards/AttackCard.gd")
var defense_card = preload("res://cards/DefenseCard.gd")
