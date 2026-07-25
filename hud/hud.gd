extends CanvasLayer

@onready var instructions : Control = $Control/Instructions
@onready var progress_bar : Control = $Control/VBoxContainer/ProgressBar
@onready var black_screen : Control = $Control/BlackScreen
@onready var victory_display : Control = $Control/VictoryDisplay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_player().health_changed.connect(on_player_health_changed)
	progress_bar.max_value = get_player().starting_health
	progress_bar.value = get_player().starting_health
	$Control/FailureDisplay.visible = false
	black_screen.visible = false
	victory_display.visible = false
	
	
func _process(_delta : float) -> void:
	var count_down : CountDown = get_parent().get_node("CountDown")
	if get_parent().get_node("CountDown").show_message:
		$Control/Panel/CountDown.text = get_parent().get_node("CountDown").message
	else:
		set_count_down_time(get_parent().get_node("CountDown").time_left)
	instructions.text = count_down.instruction_text

func on_player_health_changed(h : int) -> void:
	$Control/VBoxContainer/ProgressBar.value = h 
	
	
func get_player() -> Player:
	return get_parent().get_node_or_null("Player")
	
	
func display_failure(msg : String) -> void:
	$Control/FailureDisplay/VBoxContainer/FailureLabel.text = msg
	$Control/FailureDisplay.visible = true
	black_screen.visible = true
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
	
	
func trigger_level_complete() -> void:
	get_tree().paused = true
	black_screen.visible = true
	victory_display.visible = true


func _on_next_level_pressed() -> void:
	Main.game.level_manager.transfer_to_next_level()
