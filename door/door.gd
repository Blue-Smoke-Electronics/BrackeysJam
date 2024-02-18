extends StaticBody2D

@export var key :KeyRes


@onready var label = %Label
@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D
@onready var sprite_door_closed = %SpriteDoorClosed
@onready var audio_stream_player_2d = %AudioStreamPlayer2D


func _ready():
	modulate = key.color
	label.text = key.name

func _on_area_2d_body_entered(body):
	if body is Player:
		if GameManager.keys.has(key):
			if sprite_2d != null:
				sprite_2d.queue_free()
				sprite_door_closed.show()
				collision_shape_2d.queue_free()
				audio_stream_player_2d.play()

func _input(event):
	if event.is_action("unlock_all"):
		if sprite_2d != null:
			sprite_2d.queue_free()
			sprite_door_closed.show()
			collision_shape_2d.queue_free()
