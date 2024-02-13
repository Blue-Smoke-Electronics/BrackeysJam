class_name GostBlaster
extends Area2D

var number :int =0
var activated = false


@onready var number_lable = %NumberLable
@onready var go_to_label = %GoToLabel

signal deactivated(gost_blaster :GostBlaster)

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color.DIM_GRAY
	Signals.gost_blaster_activated.connect(_on_blaster_activated)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	number_lable.text = str(number)

func activate():
	activated =true
	modulate = Color.WHITE
	Signals.gost_blaster_activated.emit(number)
	
func deactivate():
	activated = false 
	modulate = Color.DIM_GRAY
	deactivated.emit(self)

func _on_area_entered(area):
	if activated:
		var gost = area as Monster
		if gost:
			gost.take_damage()
			deactivate()
			


func _on_blaster_activated(goto_number :int ):
	go_to_label.text = "Go to: "+ str(goto_number)
	if number == goto_number:
		go_to_label.hide()
	else :
		go_to_label.show()
