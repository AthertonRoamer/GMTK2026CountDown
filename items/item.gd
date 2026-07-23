class_name Item
extends Resource

@export var name : String
@export var pickable_scene : PackedScene
@export var pickable_image : Texture2D

func add_to_entity(_entity) -> void:
	pass
	
	
func remove_from_entity(_entity) -> void:
	pass
	
	
func use(_entity) -> void:
	pass
	
	
func place_on_ground(position : Vector2) -> void:
	if pickable_scene:
		var item_node : PickableItem = pickable_scene.instantiate()
		item_node.item_name = name
		item_node.position = position
		item_node.item = self
		Main.main.get_world().add_child(item_node)
