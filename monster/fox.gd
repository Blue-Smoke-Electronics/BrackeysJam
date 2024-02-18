class_name Fox
extends CharacterBody2D

const SPEED = 100

@export var map : TileMap
@export var player :Player

var last_position : Vector2
var is_dead = false

@onready var navigation_agent_2d = %NavigationAgent2D
@onready var animated_sprite_2d = %AnimatedSprite2D
@onready var player_kill_area = $PlayerKillArea
@onready var sprite_dead = $SpriteDead


var collided = false

func _ready():
	_set_random_target()
	pass

func _physics_process(_delta):
	
	if not is_dead:
		var dir = to_local(navigation_agent_2d.get_next_path_position())
		velocity = dir.normalized()*SPEED
		
		collided = move_and_slide()
		if velocity.length() > 0:
			animated_sprite_2d.play("walk")
			animated_sprite_2d.rotation = velocity.angle()

	
		
		
func _set_random_target():
	var cell = map.get_used_cells(0).pick_random()
	var pos  = map.map_to_local(cell)
	navigation_agent_2d.target_position = pos
	


func _on_player_kill_area_body_entered(body):
	if body is Player:
		if not is_dead:
			Signals.game_over.emit()


func _on_timer_timeout():
	if (player.global_position-global_position).length() < 250:
		navigation_agent_2d.target_position = player.global_position
	
	elif  collided  or (navigation_agent_2d.get_final_position() - position).length() < 10:  
		_set_random_target()
	
	if player_kill_area.get_overlapping_bodies().size() > 30:
		if get_tree().get_nodes_in_group("fox").size() <=1:
			Signals.game_won.emit()
		
		sprite_dead.show()
		animated_sprite_2d.hide()
		remove_from_group("fox")
		is_dead = true
		
