class_name Level
extends Node2D


func _init() -> void:
	Main.main.level = self
	

func get_world() -> Node2D:
	return self
