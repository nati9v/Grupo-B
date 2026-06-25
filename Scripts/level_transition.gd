extends CanvasLayer

@export var fade_in_time := 0.6

@onready var transition_rect: ColorRect = $ColorRect

func _ready():
	play_fade_in()

func play_fade_in() -> void:
	if transition_rect == null:
		print("No encontré el ColorRect de transición")
		return

	transition_rect.show()
	transition_rect.modulate.a = 1.0

	var tween := create_tween()
	tween.tween_property(transition_rect, "modulate:a", 0.0, fade_in_time)
	await tween.finished

	transition_rect.hide()
