extends Area2D

@export var targets: Array[Node]

func press():
	for t in targets:
		t.activate()
		$AudioStreamPlayer2D.play()
