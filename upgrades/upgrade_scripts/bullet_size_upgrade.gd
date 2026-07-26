class_name BulletSizeUpgrade
extends Upgrade

@export var bullet_size_buff : float = .5

func add_to_entity(entity) -> void:
	entity.get_node("GenericGun").bullet_size_multiplier += bullet_size_buff
