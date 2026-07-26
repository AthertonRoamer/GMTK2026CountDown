class_name SprayUpgrade
extends Upgrade


@export var spray : int = 2

func add_to_entity(entity) -> void:
	entity.get_node("GenericGun").bullet_spray += spray
	
