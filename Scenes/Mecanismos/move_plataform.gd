extends AnimatableBody2D

@export var animation_name: String = "move"
var going_up := false

func activate():
	var anim = get_node_or_null("AnimationPlayer")
	
	if anim == null:
		push_warning("Esta plataforma no tiene AnimationPlayer")
		return
	
	if not anim.has_animation(animation_name):
		push_warning("No existe la animación: " + animation_name)
		return
	
	if going_up:
		anim.play_backwards(animation_name)
	else:
		anim.play(animation_name)
	
	going_up = !going_up
