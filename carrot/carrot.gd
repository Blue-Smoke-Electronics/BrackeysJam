extends Area2D

var is_picked_up = false

@onready var audio_stream_player_2d = %AudioStreamPlayer2D


func _on_body_entered(body):
	if body is Player:
		if not is_picked_up:
			GameManager.carrot_cnt += 1
			audio_stream_player_2d.play(.2)
			hide()
			is_picked_up = true
