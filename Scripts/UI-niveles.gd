extends CanvasLayer

func _ready():
	AudioManager.play_music("res://Musica y SFX/Musica/Menu-music_1.mp3")
func _on_lvl_1_pressed() -> void:
	get_tree().change_scene_to_file("res://UI-Escenas/Cinematica.tscn")
func _on_lvl_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Niveles/lvl2.tscn")

func _on_lvl_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Niveles/lvl3.tscn")


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI-Escenas/Menu.tscn")
