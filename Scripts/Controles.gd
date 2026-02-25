extends CanvasLayer
func _ready():
	hide()

func _on_button_pressed():
	hide()
	AudioManager.play_click()



func _on_controles_pressed():
	show()
	AudioManager.play_click()


func _on_button_mouse_entered() -> void:
	AudioManager.play_hover()
