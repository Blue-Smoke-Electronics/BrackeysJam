extends Node

var keys : Array[KeyRes]

const MAIN = preload("res://main.tscn")
const GAME_OVER_MENU = preload("res://menues/game_over_menu.tscn")

func _ready():
	Signals.game_over.connect(_on_game_over)
	
func _on_game_over():
	get_tree().change_scene_to_packed(GAME_OVER_MENU)
