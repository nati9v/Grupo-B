extends AnimatableBody2D

@export var animation_name: String = "move"
var going_up := false
var anim = get_node_or_null("AnimationPlayer")

func _ready():
	anim = find_child("AnimationPlayer", true, false)
	if anim:
		anim.animation_finished.connect(_on_anim_finished)
	else:
		push_warning("No se encontró AnimationPlayer")
func activate():
	
	
	if anim == null:
		push_warning("Esta plataforma no tiene AnimationPlayer")
		return
	
	if not anim.has_animation(animation_name):
		push_warning("No existe la animación: " + animation_name)
		return
	$"Ascensor-inicio".play()
	$"Ascensor-loop".play()
	if going_up:
		anim.play_backwards(animation_name)
	else:
		anim.play(animation_name)
		
	going_up = !going_up
	
func _on_anim_finished(anim_name):
		$"Ascensor-loop".stop()
		$"Ascensor-fin".play()
