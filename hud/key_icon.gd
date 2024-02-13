extends VBoxContainer

@onready var texture_rect = %TextureRect
@onready var label = %Label

func add_key_res(key_res : KeyRes):
	if texture_rect and label : 
		modulate = key_res.color
		label.text = key_res.name
