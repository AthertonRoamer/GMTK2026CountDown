extends CanvasLayer

@onready var instructions : Control = $Control/Instructions
@onready var progress_bar : Control = $Control/VBoxContainer/ProgressBar
@onready var black_screen : Control = $Control/BlackScreen
@onready var victory_display : Control = $Control/VictoryDisplay
@onready var gun_stats_body : Control = $Control/GunStatsDisplay/Panel/VBoxContainer/Body
@onready var count_down_label : Control = $Control/CountDown
@onready var upgrade_holder : Control = $Control/UpgradeOptionDisplay/UpgradeOptionDisplay/UpgradeHolder
@onready var upgrade_option_display : Control = $Control/UpgradeOptionDisplay
var upgrade_display_scene : PackedScene = preload("res://hud/upgrade_display.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_player().health_changed.connect(on_player_health_changed)
	progress_bar.max_value = get_player().starting_health
	progress_bar.value = get_player().starting_health
	$Control/FailureDisplay.visible = false
	black_screen.visible = false
	victory_display.visible = false
	update_gun_stats()
	upgrade_option_display.visible = false
	
	
func _process(_delta : float) -> void:
	var count_down : CountDown = get_parent().get_node("CountDown")
	if get_parent().get_node("CountDown").show_message:
		count_down_label.text = get_parent().get_node("CountDown").message
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
	count_down_label.text = str(minutes) + ":" + str_seconds


func _on_restart_pressed() -> void:
	Main.game.level_manager.reload_active_level()
	
	
func trigger_level_complete() -> void:
	get_tree().paused = true
	black_screen.visible = true
	victory_display.visible = true


func _on_next_level_pressed() -> void:
	Main.game.level_manager.transfer_to_next_level()
	
	
func update_gun_stats() -> void:
	gun_stats_body.text = ""
	if not get_player().primary_item is Gun:
		return
	var gun : GenericGun = get_player().get_node("GenericGun")
	gun_stats_body.text += "Damage: " + str(gun.damage)
	gun_stats_body.text += "\nCooldown time: " + str(gun.cool_down_time)
	gun_stats_body.text += "\nBullet Speed: " + str(gun.speed)
	gun_stats_body.text += "\nBullet Size: " + str(gun.bullet_size_multiplier)
	gun_stats_body.text += "\nSpray Count: " + str(gun.bullet_spray)
	
	
func display_upgrade_options(options : Array) -> void:
	get_tree().paused = true
	for upgrade in options:
		var upgrade_display : UpgradeDisplay = upgrade_display_scene.instantiate()
		upgrade_display.upgrade = upgrade
		upgrade_holder.add_child(upgrade_display)
	upgrade_option_display.visible = true
	
	
func close_upgrade_options() -> void:
	upgrade_option_display.visible = false
	for upgrade in upgrade_holder.get_children():
		upgrade.queue_free()
	get_tree().paused = false
