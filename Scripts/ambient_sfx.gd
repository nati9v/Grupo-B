extends Area2D

@export var sound: AudioStream
@export var one_shot: bool = true
@export var volume_db: float = 0.0 

@onready var audio = $AudioStreamPlayer2D
var activated = false

func _ready():
	print(sound)
	audio.stream = sound
	audio.volume_db = volume_db

func _on_body_entered(body):
	if body.is_in_group("player") and (not activated):
		activated = true
		audio.play()
