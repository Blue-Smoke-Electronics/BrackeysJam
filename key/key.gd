extends Area2D

var is_picked_up = false

@export var key_res : KeyRes
@onready var label = %Label
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

func _ready():
	modulate = key_res.color
	label.text = key_res.name

func _on_body_entered(body):
	if body is Player:
		if not is_picked_up:
			if not GameManager.keys.has(key_res):
				GameManager.keys.append(key_res)
			is_picked_up = true
			audio_stream_player_2d.play()
			hide()
