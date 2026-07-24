class_name BasicPursueState
extends State

@export var face_walk_direction : bool = true

func process_state(delta : float) -> void:
	var walk_direction : Vector2
	var desired_direction = get_patron().global_position.direction_to(get_patron().last_known_player_position)
	if face_walk_direction:
		walk_direction = Vector2.RIGHT.rotated(get_patron().rotation)
	else:
		walk_direction = desired_direction
	get_patron().velocity = get_patron().walk_speed * walk_direction
	get_patron().move_and_slide()
	(get_patron() as Enemy).rotate_toward_direction(desired_direction, delta)
