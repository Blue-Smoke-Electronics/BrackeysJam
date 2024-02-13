extends Node

signal keys_changed

var keys : Array[KeyRes]
var _key_cnt =0

var carrot_cnt = 0
var rabbit_cnt = 0

const MAIN = preload("res://main.tscn")
const GAME_OVER_MENU = "res://menues/game_over_menu.tscn"
const GAME_WON_MENU = "res://menues/game_won_menu.tscn"

func _ready():
	Signals.game_over.connect(_on_game_over)
	Signals.game_won.connect(_on_game_won)

func _process(_delta):
	if keys.size() != _key_cnt:
		_key_cnt = keys.size()
		keys_changed.emit()
		
	if rabbit_cnt > 250:
		Signals.game_won.emit()
	
func _on_game_over():
	get_tree().change_scene_to_file(GAME_OVER_MENU)
	carrot_cnt =0
	keys.erase(keys.pick_random())
		
func _on_game_won():
	get_tree().change_scene_to_file(GAME_WON_MENU)
	carrot_cnt =0 
	rabbit_cnt =0
	for key in keys:
		keys.erase(key)

