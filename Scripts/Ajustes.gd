extends CanvasLayer
func _ready():
	hide()

func _on_controles_pressed():
	hide()
	get_parent().get_node("Controles").visible = true



func _on_cerrar_pressed():
	hide()

func _on_ajustes_pressed() -> void:
	show()

func _on_musica_pressed() -> void:
	AudioManager.toggle_music()

func _on_sfx_pressed() -> void:
	AudioManager.toggle_sfx()
