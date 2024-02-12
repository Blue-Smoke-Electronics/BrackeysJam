extends Area2D

const SPEED = 100

@export var target : Player
@export var start_trigger :Area2D

@onready var navigation_agent_2d = %NavigationAgent2D
@onready var timer = %Timer

func _ready():
	start_trigger.body_exited.connect(_on_trigger_activated)

func _physics_process(delta):
	var dir = to_local(navigation_agent_2d.get_next_path_position())
	var velocity = dir.normalized()*SPEED
	position += velocity * delta


func _make_path():
	navigation_agent_2d.target_position = target.global_position
	
func _on_timer_timeout():
	_make_path()
	pass # Replace with function body.


func _on_body_entered(body):
	if body is Player:
		Signals.game_over.emit()

func _on_trigger_activated(body):
	#if body is Player:
	if timer.is_stopped():
		_make_path()
		timer.start()
