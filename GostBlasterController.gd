extends Node

@export var gost_blasters : Array[GostBlaster]


# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.monser_escaped.connect(_on_monster_escaped)
	var numbers = range(gost_blasters.size())
	for blaster in gost_blasters:
		blaster.number = numbers.pick_random()
		numbers.erase(blaster.number)
		blaster.deactivated.connect(_on_blaster_deactivated)


func _on_monster_escaped():
	gost_blasters.pick_random().activate()

func _on_blaster_deactivated(blaster):
	gost_blasters.erase(blaster)
	if gost_blasters.size()> 0:
		gost_blasters.pick_random().activate()
