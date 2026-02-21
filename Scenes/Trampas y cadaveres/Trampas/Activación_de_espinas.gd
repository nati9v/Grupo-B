extends Node2D

func _ready():
	$StaticBody2D/CollisionShape2D.disabled = true
	$Body.visible = false


func on_local_death():
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	$Body.visible = true
