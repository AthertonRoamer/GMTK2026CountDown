class_name CustomLevel
extends Level

@onready var hud = $Hud
func _exit_tree() -> void: 
	get_tree().paused = false
