extends CanvasLayer
@export var level_music: AudioStream
func _ready():
	AudioManager.play_music(level_music)
func _on_lvl_1_pressed() -> void:
	get_tree().change_scene_to_file("res://UI-Escenas/Cinematica.tscn")
	AudioManager.play_click()


	
func _on_lvl_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Niveles/lvl2.tscn")
	AudioManager.play_click()

func _on_lvl_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Niveles/lvl3.tscn")
	AudioManager.play_click()


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI-Escenas/Menu.tscn")
	AudioManager.play_click()


func _on_texture_button_mouse_entered() -> void:
	AudioManager.play_hover()


func _on_lvl_1_mouse_entered() -> void:
	AudioManager.play_hover()



func _on_lvl_2_mouse_entered() -> void:
	AudioManager.play_hover()

func _on_lvl_3_mouse_entered() -> void:
	AudioManager.play_hover()
