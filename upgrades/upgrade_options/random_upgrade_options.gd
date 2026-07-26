class_name RandomUpgradeOptions
extends Item

@export var option_count : int = 3

func add_to_entity(_entity) -> void:
	#get upgrades from options
	var options : Array = Main.level.level_upgrade_options.upgrade_options.upgrade_options
	var selected_option_idxs : Array = []
	if option_count > options.size():
		push_error("Not enough upgrade options")
		return
	for i in range(option_count):
		var a = randi_range(0, options.size() - 1)
		while (a in selected_option_idxs):
			a = randi_range(0, options.size() - 1)
		selected_option_idxs.append(a)
	var selected_upgrades : Array = []
	for idx in selected_option_idxs:
		selected_upgrades.append(options[idx])
	Main.level.hud.display_upgrade_options(selected_upgrades)
