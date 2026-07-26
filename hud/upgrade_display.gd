class_name UpgradeDisplay
extends VBoxContainer

var upgrade : Upgrade

func _ready() -> void:
	$Label.text = upgrade.name
	$Label2.text = upgrade.description
	


func _on_button_pressed() -> void:
	upgrade.add_to_entity(Main.level.hud.get_player())
	Main.level.hud.update_gun_stats()
	Main.level.hud.close_upgrade_options()
