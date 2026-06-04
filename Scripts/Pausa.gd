extends CanvasLayer

func _ready():
	hide()
func reanudar():
	get_tree().paused = false
	hide()

func pausa():
	get_tree().paused = true
	show()

func pressEsc():
	if Input.is_action_just_pressed("Pausa") and get_tree().paused == false:
		pausa()
	elif Input.is_action_just_pressed("Pausa") and get_tree().paused == true:
		reanudar()
	
func _process(_delta):
	pressEsc()


func _on_menú_pressed():
	reanudar()
	get_tree().change_scene_to_file("res://UI-Escenas/Menu.tscn")
	AudioManager.play_click()



func _on_reanudar_pressed():
	reanudar()
	AudioManager.play_click()

func _on_reiniciar_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	AudioManager.play_click()
	

func _on_ajustes_pressed():
	get_parent().get_node("Ajustes").visible = true
	AudioManager.play_click()
	reanudar()
	hide()


func _on_texture_button_pressed():
	pausa()
	AudioManager.play_click()

func _on_texture_button_mouse_entered() -> void:
	AudioManager.play_hover()

func _on_menú_mouse_entered() -> void:
	AudioManager.play_hover()

func _on_reanudar_mouse_entered() -> void:
	AudioManager.play_hover()

func _on_reiniciar_mouse_entered() -> void:
	AudioManager.play_hover()

func _on_ajustes_mouse_entered() -> void:
	AudioManager.play_hover()
	
