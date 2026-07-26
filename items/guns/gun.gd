class_name Gun
extends PrimaryItem

@export var image : Texture2D
@export var damage : int = 10
@export var projectile_scene : PackedScene = preload("res://projectile/generic_bullet.tscn")
@export var bullet_texture : Texture2D
@export var speed : float = 1000
@export var cool_down_time : float = 0.5
@export var bullet_size_multiplier : float = 1
@export var bullet_spray : int = 1

func add_to_entity(entity) -> void:
	entity.add_primary_item(self)
	entity.get_node("GunSprite").visible = true
	entity.get_node("GunSprite").texture = image
	if entity.get_node_or_null("GunCollisionShape"):
		entity.get_node("GunCollisionShape").disabled = false
	var gun : GenericGun = entity.get_node("GenericGun")
	gun.damage = damage
	gun.projectile_scene = projectile_scene
	gun.speed = speed
	gun.bullet_texture = bullet_texture
	gun.cool_down_time = cool_down_time
	gun.bullet_size_multiplier = bullet_size_multiplier
	gun.bullet_spray = bullet_spray
	if Main.level.hud:
		Main.level.hud.update_gun_stats()
		
	
func remove_from_entity(entity) -> void:
	if entity.get_node_or_null("GunCollisionShape"):
		entity.get_node("GunCollisionShape").disabled = true
	entity.get_node("GunSprite").visible = false


func use(entity) -> void:
	var gun : GenericGun = entity.get_node("GenericGun")
	gun.projectile_direction = entity.global_position.direction_to(entity.get_global_mouse_position())
	gun.fire()
	
