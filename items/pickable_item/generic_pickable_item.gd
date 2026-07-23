class_name GenericPickableItem
extends PickableItem

@export var item : Item

func _ready() -> void:
	$Sprite2D.texture = item.pickable_image
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("grab"):
		for body in get_overlapping_bodies():
			if body is Player:
				item.add_to_entity(body)
				queue_free()
				
				
func update_label_status() -> void:
	var bodies : Array = get_overlapping_bodies()
	
	$Label.visible = not bodies.filter(func(body): return body is Player).is_empty()


func _on_body_entered(_body: Node2D) -> void:
	update_label_status()


func _on_body_exited(_body: Node2D) -> void:
	update_label_status()
