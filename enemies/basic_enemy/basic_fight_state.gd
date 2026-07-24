class_name BasicFightState
extends State

func process_state(delta : float) -> void:
	get_patron().rotate_toward_player(delta)
	if get_patron().can_hit_player():
			get_patron().fire()
