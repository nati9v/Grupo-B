extends RigidBody2D

@export var weight_value := 1

func _ready():
	contact_monitor = true
	max_contacts_reported = 4
