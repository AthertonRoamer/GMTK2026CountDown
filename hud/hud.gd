extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_player().health_changed.connect(on_player_health_changed)
	$Control/VBoxContainer/ProgressBar.max_value = get_player().starting_health
	$Control/VBoxContainer/ProgressBar.value = get_player().starting_health
	$Control/FailureDisplay.visible = false
	
	
func _process(delta : float) -> void:
	set_count_down_time(get_parent().get_node("CountDown").time_left)

func on_player_health_changed(h : int) -> void:
	$Control/VBoxContainer/ProgressBar.value = h 
	
	
func get_player() -> Player:
	return get_parent().get_node_or_null("Player")
	
	
func display_failure(msg : String) -> void:
	$Control/FailureDisplay/VBoxContainer/FailureLabel.text = msg
	$Control/FailureDisplay.visible = true
	get_tree().paused = true
	
	
func set_count_down_time(sec : float):
	@warning_ignore("integer_division")
	var minutes : int = int(sec) / 60
	var seconds : int = int(sec) % 60
	var str_seconds : String
	if seconds < 10:
		str_seconds = "0" + str(seconds)
	else:
		str_seconds = str(seconds)
	$Control/Panel/CountDown.text = str(minutes) + ":" + str_seconds


func _on_restart_pressed() -> void:
	Main.game.level_manager.reload_active_level()
