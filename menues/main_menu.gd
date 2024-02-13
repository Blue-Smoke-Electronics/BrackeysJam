extends Control

const MAIN = preload("res://main.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_button_play_pressed():
	get_tree().change_scene_to_packed(MAIN)

func _on_button_quit_pressed():
	get_tree().quit()
