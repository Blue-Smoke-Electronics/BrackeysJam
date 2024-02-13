extends Area2D

@export var key_res : KeyRes
@onready var label = %Label

func _ready():
	modulate = key_res.color
	label.text = key_res.name

func _on_body_entered(body):
	if body is Player:
		if not GameManager.keys.has(key_res):
			GameManager.keys.append(key_res)
		queue_free()
