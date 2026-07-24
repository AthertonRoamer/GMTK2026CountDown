extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_player().health_changed.connect(on_player_health_changed)
	$Control/VBoxContainer/ProgressBar.max_value = get_player().starting_health
	$Control/VBoxContainer/ProgressBar.value = get_player().starting_health


func on_player_health_changed(h : int) -> void:
	$Control/VBoxContainer/ProgressBar.value = h 
	
	
func get_player() -> Player:
	return get_parent().get_node_or_null("Player")
