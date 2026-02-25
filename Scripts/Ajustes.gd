extends CanvasLayer
func _ready():
	hide()

func _on_controles_pressed():
	hide()
	get_parent().get_node("Controles").visible = true
	AudioManager.play_click()



func _on_cerrar_pressed():
	hide()
	AudioManager.play_click()

func _on_ajustes_pressed() -> void:
	show()
	AudioManager.play_click()

func _on_musica_pressed() -> void:
	AudioManager.toggle_music()
	AudioManager.play_click()

func _on_sfx_pressed() -> void:
	AudioManager.toggle_sfx()
	AudioManager.play_click()

func _on_musica_mouse_entered() -> void:
	AudioManager.play_hover()

func _on_sfx_mouse_entered() -> void:
	AudioManager.play_hover()

func _on_controles_mouse_entered() -> void:
	AudioManager.play_hover()
