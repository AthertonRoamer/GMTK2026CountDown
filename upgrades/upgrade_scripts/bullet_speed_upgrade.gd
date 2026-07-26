class_name BulletSpeedUpgrade
extends Upgrade

@export var bullet_speed_buff : float = 200

func add_to_entity(entity) -> void:
	entity.get_node("GenericGun").speed += bullet_speed_buff
