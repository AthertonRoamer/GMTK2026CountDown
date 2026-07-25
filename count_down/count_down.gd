class_name CountDown
extends Timer

@export var objective_run_failure_message : String
var objective_completed : bool = false
var objective_run : bool = true #if false means hes exiting the facility

func _on_timeout() -> void:
	if objective_run and not objective_completed:
		trigger_failure(objective_run_failure_message)
		
		
func trigger_failure(message : String) -> void:
	$"../Hud".display_failure(message)
