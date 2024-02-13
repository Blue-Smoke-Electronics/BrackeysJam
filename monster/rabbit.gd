class_name Rabbit
extends CharacterBody2D


const SPEED = 200.0
const RABBIT = "res://monster/rabbit_new.tscn"


var target :Node2D  = null


#@onready var mating_range = $MatingRange
@onready var navigation_agent_2d = %NavigationAgent2D
@onready var timer_mating = %TimerMating


func _ready():
	_set_random_target()
	GameManager.rabbit_cnt += 1
	
func _physics_process(_delta):
	var dir = to_local(navigation_agent_2d.get_next_path_position())
	velocity = dir.normalized()*SPEED
	move_and_slide()

func _on_timer_timeout():
	if target:
		navigation_agent_2d.target_position = target.global_position
	
	elif navigation_agent_2d.get_final_position().distance_to(global_position) < 10: 
		_set_random_target()
	
func _set_random_target():
	var map = get_tree().get_nodes_in_group("map")[0]
	var cell = map.get_used_cells(0).pick_random()
	var pos  = map.map_to_local(cell)
	navigation_agent_2d.target_position = pos
	
func _on_timer_mating_timeout():
	target = get_tree().get_nodes_in_group("rabbit").pick_random()

func _on_mating_range_body_entered(body):
	if body == target:
		for i in 5:
			var child = load(RABBIT).instantiate()
			get_parent().add_child(child)
			child.global_position = global_position +Vector2(randf()*20+5,randf()*20+5)
		target = null
		_set_random_target()
		#queue_free()
		timer_mating.start()
