class_name ExtractionPoint
extends InteractableObject

func on_player_interact() -> void:
	get_parent().get_node("Hud").trigger_level_complete()
