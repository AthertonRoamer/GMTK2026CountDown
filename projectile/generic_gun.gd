class_name GenericGun
extends CoolDownProjectileHandler

@export var damage : int = 10
@export var bullet_texture : Texture2D
@export var speed : float = 500
@export var bullet_size_multiplier : float = 1
@export var bullet_spray : int = 1
@export var spray_dif_angle : float = 5
var sound : AudioStreamPlayer2D

func _ready() -> void:
	super()
	sound = AudioStreamPlayer2D.new()
	sound.stream = preload("res://assets/sound/laser_sound.wav")
	add_child(sound)

func set_up_projectile() -> Projectile:
	var new_projectile : Projectile = super()
	new_projectile.damage = damage
	new_projectile.texture = bullet_texture
	new_projectile.speed = speed
	new_projectile.scale *= bullet_size_multiplier
	return new_projectile
	
	
func fire_projectile() -> void:
	cool_down_time_elapsed = 0
	var coefficients : Array = []
	var a : int = bullet_spray
	if a % 2 == 1:
		a -= 1
		coefficients.append(0)
	@warning_ignore("integer_division")
	for b in range(a/2):
		coefficients.append(b + 1)
		coefficients.append((1 + b) * -1)
	for i in coefficients:
		var new_projectile = set_up_projectile()
		new_projectile.direction = new_projectile.direction.rotated(i * deg_to_rad(spray_dif_angle))
		new_projectile.rotation = new_projectile.direction.angle() + PI / 2
		Main.main.get_world().add_child(new_projectile)
	sound.play()
