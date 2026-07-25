class_name BombPlantZone
extends InteractableObject

var planting : bool = false
@export var plant_time : float = 2
var plant_time_elapsed : float = 0
var planted : bool = false
@onready var count_down : CountDown = get_parent().get_node("CountDown")

func _ready() -> void:
	super()
	
	count_down.objective_just_completed.connect(on_objective_completed)
	visible = false
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("plant") and not planted:
		planting = true
		$Sprite2D.visible = true
		$BombSprite.visible = true
		$Sprite2D/Timer.start()
	if Input.is_action_just_released("plant") and not planted:
		planting = false
		$BombSprite.visible = false
	if planting:
		$Sprite2D.visible = true
		plant_time_elapsed += delta
		if plant_time_elapsed >= plant_time:
			plant()
			
			
func plant() -> void:
	planted = true
	planting = false
	$BombSprite.visible = true
	active = false
	$Label.visible = false
	$StaticBody2D/CollisionShape2D.disabled = false
	count_down.bomb_planted()
	
		
	
	
func on_objective_completed() -> void:
	active = true
	visible = true


func _on_timer_timeout() -> void:
	if planted:
		return
	if not planting:
		$Sprite2D.visible = not $Sprite2D.visible
	if planting:
		$BombSprite.visible = not $BombSprite.visible
		
		
	
