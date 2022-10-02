class_name Strategy
extends Node


var sprite_path := "res://icon.png"
var title := "base strategy title"
var description := "base strategy description"
var color := Color("yellow")
var bonuses := {} # Don't know what this will be yet.
var cards := [] # Bonuse cards!

var attack_card := load("res://cards/AttackCard.gd")
var defense_card := load("res://cards/DefenseCard.gd")
var bonus_card := load("res://cards/BonusCard.gd")
