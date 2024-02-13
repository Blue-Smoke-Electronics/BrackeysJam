extends CanvasLayer


const KEY_ICON = preload("res://hud/key_icon.tscn")

@onready var key_container = %keyContainer
@onready var carrot_cnt_lable = %CarrotCntLable

func _ready():
	GameManager.keys_changed.connect(_on_key_change)
	_on_key_change()

func _process(_delta):
	carrot_cnt_lable.text = str(GameManager.carrot_cnt)

func _on_key_change():
	for child in key_container.get_children():
		child.queue_free()
	
	for key in GameManager.keys:
		var icon = KEY_ICON.instantiate()
		key_container.add_child(icon)
		icon.add_key_res(key)
		
