class_name GenericBullet
extends Projectile

@export var texture : Texture2D

func _ready() -> void:
	super()
	$Sprite2D.texture = texture
