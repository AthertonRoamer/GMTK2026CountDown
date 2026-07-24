class_name ProjectileHandler
extends Node2D

@export var projectile_scene : PackedScene = null #should extend Projectile
@export var fire_position_node : Node2D = null
@export var wielder : Node2D = null

var projectile_direction : Vector2 = Vector2.RIGHT

var firing_constantly : bool = false

func _ready() -> void:
	if projectile_scene == null:
		projectile_scene = preload("res://projectile/generic_bullet.tscn")
	if fire_position_node == null:
		fire_position_node = self
	if wielder == null:
		wielder = get_parent()

func set_up_projectile() -> Projectile:
	var new_projectile : Projectile = projectile_scene.instantiate()
	new_projectile.global_position = get_fire_position()
	new_projectile.direction = projectile_direction
	new_projectile.rotation = projectile_direction.angle() + PI / 2
	new_projectile.wielder = wielder
	return new_projectile


func fire() -> void:
	if can_fire():
		fire_projectile()
		
		
func fire_projectile() -> void:
	var new_projectile = set_up_projectile()
	Main.main.get_world().add_child(new_projectile)


func get_fire_position() -> Vector2:
	return fire_position_node.global_position 
	
	
func can_fire() -> bool:
	return true


func begin_firing_constantly() -> void:
	firing_constantly = true


func stop_firing_constantly() -> void:
	firing_constantly = false
	
	
func _process(_delta: float) -> void:
	if firing_constantly:
		fire()
