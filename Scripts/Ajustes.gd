extends CanvasLayer
func _ready():
	hide()

func _on_controles_pressed():
	get_parent().get_node("Controles").visible = true


func _on_cerrar_pressed():
	hide()

func _on_ajustes_pressed() -> void:
	show()
