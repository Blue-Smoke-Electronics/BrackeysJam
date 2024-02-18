class_name Player
extends CharacterBody2D


@export var speed = 300
@onready var animated_sprite_2d = %AnimatedSprite2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D



func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity =input_direction * speed
	if velocity.x < 0:
		animated_sprite_2d.flip_v = true
	elif velocity.x > 0 :
		animated_sprite_2d.flip_v = false
	
	
	
	if velocity.length() != 0:
		animated_sprite_2d.rotation = velocity.angle()
		animated_sprite_2d.play("move")
		#audio_stream_player_2d.stream_paused = true

	else :
		animated_sprite_2d.play("idle")
		animated_sprite_2d.rotation = 0
		animated_sprite_2d.flip_v = false
		#if not audio_stream_player_2d.playing:
			#audio_stream_player_2d.stream_paused = false
		


func _physics_process(_delta):

	get_input()
	move_and_slide()
