extends Node2D

@onready var player := $Pruebeteoprimus
@onready var pausa = $Pausa
@export var level_music: AudioStream

func _ready():
	checkpoint_manager.set_checkpoint(player.global_position)
	AudioManager.play_music(level_music)

func _on_texture_button_pressed():
	pausa.pausa()
