class_name CoolDownProjectileHandler
extends ProjectileHandler

@export var cool_down_time : float = 0.1
var cool_down_time_elapsed : float = cool_down_time

func _process(delta: float) -> void:
	if firing_constantly:
		fire()
	cool_down_time_elapsed += delta
	
	
func fire_projectile() -> void:
	cool_down_time_elapsed = 0
	var new_projectile = set_up_projectile()
	Main.main.get_world().add_child(new_projectile)
		
		
func can_fire() -> bool:
	return cool_down_time_elapsed > cool_down_time
