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

func _on_reanudar_pressed():
	reanudar()

func _on_reiniciar_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	

func _on_ajustes_pressed():
	get_parent().get_node("Ajustes").visible = true
	reanudar()
	hide()


func _on_texture_button_pressed():
	pausa()



	
