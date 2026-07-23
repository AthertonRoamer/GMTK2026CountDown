class_name Door
extends StaticBody2D

@export var open : bool = true

func update_open() -> void:
	if open:
		$Sprite2D.frame = 5
		$Door.disabled = true
	else:
		$Sprite2D.frame = 4
		$Door.disabled = false
		
		
func _ready() -> void:
	update_open()
