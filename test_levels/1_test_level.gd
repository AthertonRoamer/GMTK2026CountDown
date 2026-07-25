extends CustomLevel

@onready var hud = $Hud
func _exit_tree() -> void: 
	get_tree().paused = false
