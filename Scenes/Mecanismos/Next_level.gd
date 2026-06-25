extends Area2D

@export var next_level_path : String
@export var transition_time := 0.6
@export var wait_before_change := 3.0
@export var transition_rect_path: NodePath

@onready var transition_rect: ColorRect = get_node_or_null(transition_rect_path)

func go_to_next_level():
	set_monitoring(false)

	if CorpseManager.has_method("reset_corpses"):
		CorpseManager.reset_corpses()

	await get_tree().create_timer(wait_before_change).timeout

	if transition_rect:
		transition_rect.visible = true
		transition_rect.color = Color(0, 0, 0, 0)

		var tween := create_tween()
		tween.tween_property(transition_rect, "color:a", 1.0, transition_time)
		await tween.finished

	get_tree().change_scene_to_file(next_level_path)

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.can_move = false
		go_to_next_level()
