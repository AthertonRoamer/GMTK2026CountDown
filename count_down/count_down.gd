class_name CountDown
extends Timer

signal objective_just_completed
signal bomb_just_planted

@export var bomb_wait_time : float = 60
@export var initial_instruction_text : String = "Enter the facility and disarm the nuke"
@export var objective_run_failure_message : String = "The nuke launched. You failed to stop it in time."
@export var objective_completed_message : String = "Nuke Disarmed"
@export var objective_completed_instruction_text : String = "Place the bomb in the bomb zone"
@export var bomb_placed_instruction_text : String = "Escape the facility"
@export var escape_failure_message : String = "You died in the bomb blast"
@export var victory_message : String = "You completed the level"
var objective_completed : bool = false
var objective_run : bool = true #if false means hes exiting the facility
@onready var message : String = objective_completed_message
var show_message : bool = false



var instruction_text : String = initial_instruction_text


func complete_objective() -> void:
	show_message = true
	objective_completed = true
	instruction_text = objective_completed_instruction_text
	objective_just_completed.emit()


func _on_timeout() -> void:
	if objective_run and not objective_completed:
		trigger_failure(objective_run_failure_message)
	if not objective_run:
		trigger_failure(escape_failure_message)


func trigger_failure(msg : String) -> void:
	$"../Hud".display_failure(msg)
	
	
func bomb_planted() -> void:
	show_message = false
	instruction_text = bomb_placed_instruction_text
	wait_time = bomb_wait_time
	start()
	objective_run = false
	bomb_just_planted.emit()
	
