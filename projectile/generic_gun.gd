class_name GenericGun
extends CoolDownProjectileHandler

@export var damage : int = 10
@export var bullet_texture : Texture2D
@export var speed : float = 500

func set_up_projectile() -> Projectile:
	var new_projectile : Projectile = super()
	new_projectile.damage = damage
	new_projectile.texture = bullet_texture
	new_projectile.speed = speed
	return new_projectile
