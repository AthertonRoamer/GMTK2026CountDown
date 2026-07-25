class_name ControlPanel
extends InteractableObject

@export var message : String

func _ready() -> void:
	super()
	$Label.text = message
	$Label.visible = false
	
	
func on_player_entered() -> void:
	$Label.visible = true
	
	
func on_player_exited() -> void:
	$Label.visible = false
	
