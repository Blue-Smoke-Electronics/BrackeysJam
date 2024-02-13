class_name Monster
extends Area2D

const SPEED = 100

@export var target : Player
@export var start_trigger :Area2D

var health :int = 3

@onready var navigation_agent_2d = %NavigationAgent2D
@onready var timer = %Timer
@onready var sprite_lamb = %SpriteLamb
@onready var sprite_monster = %SpriteMonster
@onready var progress_bar = %ProgressBar

func _ready():
	start_trigger.body_exited.connect(_on_trigger_activated)

func _physics_process(delta):
	var dir = to_local(navigation_agent_2d.get_next_path_position())
	var velocity = dir.normalized()*SPEED

	if to_local(target.global_position).length() > 800:
		velocity *= 10
	position += velocity * delta



func take_damage():
	health -= 1
	progress_bar.value = health
	progress_bar.show()
	if health <=0:
		queue_free()
		Signals.game_won.emit()

func _make_path():
	navigation_agent_2d.target_position = target.global_position
	
	
func _on_timer_timeout():
	_make_path()
	pass # Replace with function body.


func _on_body_entered(body):
	if body is Player:
		Signals.game_over.emit()

func _on_trigger_activated(_body):
	if timer.is_stopped():
		_make_path()
		timer.start()
		sprite_lamb.hide()
		sprite_monster.show()
		Signals.monser_escaped.emit()
