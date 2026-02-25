extends Control
@export var level_music: AudioStream

func _ready():
	AudioManager.play_music(level_music)
	
func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://UI-Escenas/Niveles.tscn")
	AudioManager.play_click()
	
func _on_jugar_mouse_entered() -> void:
	AudioManager.play_hover()

func _on_salir_pressed() -> void:
	get_tree().quit()
	AudioManager.play_click()

func _on_salir_mouse_entered() -> void:
	AudioManager.play_hover()

func _on_ajustes_mouse_entered() -> void:
	AudioManager.play_hover()

func _on_controles_mouse_entered() -> void:
	AudioManager.play_hover()
