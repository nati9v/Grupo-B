extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Algo entró:", body.name)

	if body.is_in_group("player"):
		print("Checkpoint activado")
		checkpoint_manager.set_checkpoint(global_position)
