class_name HealthUpgrade
extends Upgrade

@export var health_buff = 25

func add_to_entity(entity) -> void:
	entity.health += 25
