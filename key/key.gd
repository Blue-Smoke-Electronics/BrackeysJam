extends Area2D

@export var key_res : KeyRes
@onready var label = %Label

func _ready():
	modulate = key_res.color
	label.text = key_res.name

func _on_body_entered(body):
	GameManager.keys.append(key_res)
	queue_free()
