class_name Turret
extends StaticBody2D

@export var sight_range : float = 400
@export var rotation_speed : float = 30
@export var fire_angle : float = 5
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
	$VisionArea/CollisionShape2D.shape.radius = sight_range
	$RayCast2D.target_position = Vector2.RIGHT * sight_range
	add_to_group("damageable")


func _process(_delta: float) -> void:
	if can_see_player():
		rotate_toward_player()
		if can_hit_player():
			fire()
			
			
func fire():
	$GenericGun.fire()
		
		
func can_hit_player() -> bool:
	return false


func rotate_toward_player() -> void:
	global_rotation = current_direction.angle()
	
	
func rotate_toward_direction(target_direction : Vector2, delta : float, rotation_speed_deg : float = rotation_speed) -> void:
	var rsign : int = sign(current_direction.angle_to(target_direction))
	var rspeed : float = deg_to_rad(rotation_speed_deg)
	if abs(current_direction.angle_to(target_direction)) < rspeed * delta:
		current_direction = target_direction #if you have more than enough rotation speed to get to the desired direction, you just rotate straight to it and not past it
	else:
		current_direction = current_direction.rotated(rspeed * delta * rsign)
	
	
func get_player() -> Node2D:
	return null


func can_see_player() -> bool:
	return false
	
	
func take_damage(dmg, _dmg_type : String = "default") -> void:
	health -= dmg
	
	
func die():
	queue_free()
