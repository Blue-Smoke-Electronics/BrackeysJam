class_name Rabbit
extends CharacterBody2D


var speed = 100.0
const RABBIT = "res://monster/rabbit_new.tscn"


var target :Node2D  = null


#@onready var mating_range = $MatingRange
@onready var navigation_agent_2d = %NavigationAgent2D
@onready var timer_mating = %TimerMating
@onready var sprite_2d = $Sprite2D


func _ready():
	_set_random_target()
	GameManager.rabbit_cnt += 1
	speed = randf_range(speed/2,speed*2)
	
func _physics_process(_delta):
	var dir = to_local(navigation_agent_2d.get_next_path_position())
	velocity = dir.normalized()*speed
	if target:
		velocity *= 2
	move_and_slide()
	
	if velocity.x < 0:
		sprite_2d.flip_h = true
	elif velocity.x > 0 :
		sprite_2d.flip_h = false

func _on_timer_timeout():
	if is_instance_valid(target):
		navigation_agent_2d.target_position = target.global_position
	
	elif navigation_agent_2d.get_final_position().distance_to(global_position) < 10: 
		_set_random_target()
	
func _set_random_target():
	var map = get_tree().get_nodes_in_group("map")[0]
	var cell = map.get_used_cells(0).pick_random()
	var pos  = map.map_to_local(cell)
	navigation_agent_2d.target_position = pos
	
func _on_timer_mating_timeout():
	var rabits = get_tree().get_nodes_in_group("rabbit")
	if rabits.size() < 50:
		target = get_tree().get_nodes_in_group("player")[0]
	else :
		target = get_tree().get_nodes_in_group("fox").front()
		timer_mating.start()

func _on_mating_range_body_entered(body):
	if body == target:
		for i in 3:
			var child = load(RABBIT).instantiate()
			get_parent().add_child(child)
			child.global_position = global_position +Vector2(randf()*20+5,randf()*20+5)
		target = null
		_set_random_target()
		#queue_free()
		timer_mating.start()
		
