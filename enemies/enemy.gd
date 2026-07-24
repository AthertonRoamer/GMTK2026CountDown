class_name Enemy
extends CharacterBody2D

@onready var state_machine : StateMachine = $StateMachine
@export_enum("loop", "up_down") var patrol_mode : String = "loop"
@export var walk_speed : float = 250
@export var rotation_speed : float = 400
@export var route : Node2D
@export var sight_range : float = 400
@export var pursue_distance : float = 350
var current_direction : Vector2 = Vector2.RIGHT
var last_known_player_position : Vector2 

var starting_health : float = 100
var health = starting_health:
	set(v):
		if v <= 0:
			health = 0
			die()
		else:
			health = v
			
			
func _ready() -> void:
	$VisionArea/CollisionShape2D.shape.radius = sight_range
	$ShootRayCast2D.target_position = Vector2.RIGHT * sight_range
	add_to_group("damageable")
	
	
func rotate_toward_direction(target_direction : Vector2, delta : float, rotation_speed_deg : float = rotation_speed) -> void:
	var rsign : int = sign(current_direction.angle_to(target_direction))
	var rspeed : float = deg_to_rad(rotation_speed_deg)
	if abs(current_direction.angle_to(target_direction)) < rspeed * delta:
		current_direction = target_direction #if you have more than enough rotation speed to get to the desired direction, you just rotate straight to it and not past it
	else:
		current_direction = current_direction.rotated(rspeed * delta * rsign)
		
		
func _physics_process(_delta) -> void:
	global_rotation = current_direction.angle()
	set_state()
	
	
func set_state() -> void:
	if can_see_player():
		last_known_player_position = get_player().global_position
		if global_position.distance_to(last_known_player_position) > pursue_distance:
			$StateMachine.set_state("pursue")
		else:
			($StateMachine as StateMachine).set_state("fight")
	elif ($StateMachine as StateMachine).active_state.id == "fight":
		$StateMachine.set_state("pursue")
	elif $StateMachine.active_state.id == "pursue":
		if global_position.distance_to(last_known_player_position) < 20:
			$StateMachine.set_state("patrol")
	
func fire():
	$GenericGun.projectile_direction = Vector2.RIGHT.rotated(rotation)
	$GenericGun.fire()
		
		
func can_hit_player() -> bool:
	if not can_see_player():
		return false
	var player : Player = get_player()
	if $ShootRayCast2D.get_collider() != player:
		return false
	return abs(global_position.direction_to(player.global_position).angle_to(Vector2.RIGHT.rotated(rotation))) < PI/32
	
	
func get_player() -> Node2D:
	for body in $VisionArea.get_overlapping_bodies():
		if body is Player:
			return body
	return null
	
	
func rotate_toward_player(delta : float) -> void:
	if not can_see_player():
		return
	var player : Player = get_player()
	rotate_toward_direction(global_position.direction_to(player.global_position), delta)
	global_rotation = current_direction.angle()


func can_see_player() -> bool:
	var player = get_player()
	if player == null:
		return false
	$CanSeePlayerRayCast2D.target_position = to_local(player.global_position) 
	$CanSeePlayerRayCast2D.force_raycast_update()
	return $CanSeePlayerRayCast2D.get_collider() == player
			
			
func take_damage(dmg, _dmg_type : String = "default") -> void:
	health -= dmg
	
	
func die():
	queue_free()
	
