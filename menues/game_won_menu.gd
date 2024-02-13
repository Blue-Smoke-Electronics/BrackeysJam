extends Control

const MAIN = preload("res://main.tscn")



func _on_button_retry_pressed():
	get_tree().change_scene_to_packed(MAIN)


func _on_button_quit_pressed():
	get_tree().quit()
