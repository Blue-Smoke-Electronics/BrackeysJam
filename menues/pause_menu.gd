extends CanvasLayer



func _input(event):
	if event.is_action_pressed("pause"):
		if get_tree().paused :
			get_tree().paused = false
		else : 
			get_tree().paused = true
		visible =! visible
		


func _on_button_continue_pressed():
	hide()
	get_tree().paused = false

func _on_button_quit_pressed():
	get_tree().quit()
