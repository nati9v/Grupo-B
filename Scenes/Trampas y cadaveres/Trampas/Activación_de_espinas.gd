extends Node2D

var is_corpse := false

func _ready():
	$StaticBody2D/CollisionShape2D.disabled = true
	$Body.visible = false


func on_local_death():

	if is_corpse:
		return

	is_corpse = true

	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	$Body.visible = true

	CorpseManager.register_corpse(self)


func remove_corpse_state():

	is_corpse = false

	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	$Body.visible = false
