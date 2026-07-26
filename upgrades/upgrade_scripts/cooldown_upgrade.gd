class_name CoolDownUpgrade
extends Upgrade

@export var cool_down_percentage : float = .8

func add_to_entity(entity) -> void:
	entity.get_node("GenericGun").cool_down_time *= cool_down_percentage
