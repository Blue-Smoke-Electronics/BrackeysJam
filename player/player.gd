class_name Player
extends CharacterBody2D


@export var speed = 300
@onready var animated_sprite_2d = %AnimatedSprite2D


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
	else :
		animated_sprite_2d.play("idle")
		animated_sprite_2d.rotation = 0
		animated_sprite_2d.flip_v = false


func _physics_process(_delta):

	get_input()
	move_and_slide()
