extends Area2D

@export var targets: Array[Node]
var activadores := 0

func _on_area_entered(area):
	if area.is_in_group("Electrocutado"):
		activadores += 1
		press()

func _on_area_exited(area):
	if area.is_in_group("Electrocutado"):
		activadores -= 1
		if activadores <= 0:
			release()

func press():
	for t in targets:
		t.activate()

func release():
	for t in targets:
		if "deactivate" in t:
			t.deactivate()
