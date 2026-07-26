class_name DamageUpgrade
extends Upgrade

@export var damage : int = 15

func add_to_entity(entity) -> void:
	entity.get_node("GenericGun").damage += damage
