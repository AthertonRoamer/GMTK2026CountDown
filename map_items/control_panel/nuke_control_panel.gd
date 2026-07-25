class_name NukeControlPanel
extends ControlPanel

@export var final_message : String 

func on_player_interact() -> void:
	Main.main.get_world().get_node("CountDown").complete_objective()
	$Label.text = final_message
