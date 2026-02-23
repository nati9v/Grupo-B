extends Control

func _ready():
	AudioManager.play_music("res://Musica y SFX/Musica/Menu-music_1.mp3")
func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://UI-Escenas/Niveles.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
