class_name Door
extends StaticBody2D



@export var open : bool = false
@export var locked : bool = true

func update_open() -> void:
	if open:
		$Sprite2D.frame = 5
		$Door.disabled = true
	else:
		$Sprite2D.frame = 4
		$Door.disabled = false
		
		
func _ready() -> void:
	update_open()
	
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		for body in $Area2D.get_overlapping_bodies():
			if body is Player:
				if locked: 
					if body.keys > 0 :
						locked = false
						body.keys -= 1
						open = not open
				else :
					open = not open
				update_open()
			
