extends Area2D

@export var targets: Array[Node]

var activadores := {}
var is_pressed := false


func _on_body_entered(body: Node2D) -> void:
	
	if not body.is_in_group("electrocutado"):
		return

	activadores[body] = true

	# Detectar cuando el cuerpo desaparece
	body.tree_exited.connect(_on_body_removed.bind(body))

	update_state()


func _on_body_exited(body: Node2D) -> void:

	if not body.is_in_group("electrocutado"):
		return

	activadores.erase(body)
	update_state()


func _on_body_removed(body: Node2D) -> void:

	activadores.erase(body)
	update_state()


func update_state():

	if activadores.size() > 0:
		if not is_pressed:
			is_pressed = true
			press()
	else:
		if is_pressed:
			is_pressed = false
			release()


func press():
	for t in targets:
		if is_instance_valid(t) and t.has_method("activate"):
			t.activate()


func release():
	for t in targets:
		if is_instance_valid(t) and t.has_method("deactivate"):
			t.deactivate()
