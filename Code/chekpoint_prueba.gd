extends Area2D

func _on_body_entered(body: Node2D) -> void:

	if body.is_in_group("player"):
		checkpoint_manager.set_checkpoint(global_position)
		$CheckpointSFX.play()
		$PointLight2D.show()
