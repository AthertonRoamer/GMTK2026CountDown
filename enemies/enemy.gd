class_name Enemy
extends CharacterBody2D

@onready var state_machine : StateMachine = $StateMachine
@export_enum("loop", "up_down") var patrol_mode : String = "loop"
@export var walk_speed : float = 250
@export var rotation_speed : float = 400
@export var route : Node2D
var current_direction : Vector2 = Vector2.RIGHT

var starting_health : float = 100
var health = starting_health:
	set(v):
		if v <= 0:
			health = 0
			die()
		else:
			health = v
			
			
func _ready() -> void:
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
			
			
func take_damage(dmg, _dmg_type : String = "default") -> void:
	health -= dmg
	
	
func die():
	queue_free()
	
