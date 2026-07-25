class_name InteractableObject
extends Area2D

@export var player_presence_label : bool = false
@export var active : bool = true

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	if player_presence_label:
		$Label.visible = false
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and active:
		for body in get_overlapping_bodies():
			if body is Player:
				on_player_interact()
				
				
func on_player_interact() -> void:
	pass
	
	
func on_player_entered() -> void:
	if player_presence_label:
		$Label.visible = true
	
	
func on_player_exited() -> void:
	if player_presence_label:
		$Label.visible = false
	
	
func _on_body_entered(body) -> void:
	if body is Player and active:
		on_player_entered()


func _on_body_exited(body) -> void:
	if body is Player and active:
		on_player_exited()
