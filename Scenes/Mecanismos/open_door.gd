extends Node2D

func _ready():
	$SpriteOpen.visible = false
	$SpriteClosed.visible = true

var is_open := false

func activate():
	is_open = !is_open
	
	$StaticBody2D/CollisionShape2D.disabled = is_open
	
	$SpriteClosed.visible = !is_open
	$SpriteOpen.visible = is_open
