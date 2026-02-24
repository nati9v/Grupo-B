extends Node2D

@onready var player := $Pruebeteoprimus
@onready var pausa = $Pausa

func _ready():
	checkpoint_manager.set_checkpoint(player.global_position)
	AudioManager.play_music("res://Musica y SFX/Musica/Lvl2-music.mp3")

func _on_texture_button_pressed():
	pausa.pausa()
