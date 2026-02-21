extends TextureButton
func _ready():
	# Busca el AnimationPlayer automáticamente si está como hijo
	pass

func _on_mouse_entered():
	$AnimationPlayer.play("hover")

func _on_mouse_exited():
	$AnimationPlayer.play("exit")
