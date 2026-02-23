extends Node2D
@onready var pausa = $Pausa
func _ready():
	AudioManager.play_music("res://Musica y SFX/Musica/lvl2-music.mp3")


func _on_texture_button_pressed():
	pausa.pausa()
	
