extends Area2D

@export var next_level_path : String

func go_to_next_level():
	set_monitoring(false)
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file(next_level_path)

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.can_move = false
		go_to_next_level()
