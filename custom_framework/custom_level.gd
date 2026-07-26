class_name CustomLevel
extends Level

@onready var level_upgrade_options : LevelUpgradeOptions = $LevelUpgradeOptions
@onready var hud = $Hud
func _exit_tree() -> void: 
	get_tree().paused = false
