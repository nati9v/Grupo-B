extends Node

var music_player: AudioStreamPlayer
var hover_player: AudioStreamPlayer
var click_player: AudioStreamPlayer

var current_music: String = ""

var music_muted := false
var sfx_muted := false


func _ready():
	#crea un nuevo audio stream y le asigna el bus "Musica"
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Musica"
	add_child(music_player)
	
	hover_player = AudioStreamPlayer.new()
	hover_player.bus = "SFX"
	hover_player.stream = load("res://Musica y SFX/UI-SFX/hover.mp3")
	add_child(hover_player)
	
	click_player = AudioStreamPlayer.new()
	click_player.bus = "SFX"
	click_player.stream = load("res://Musica y SFX/UI-SFX/Click_Combo.wav")
	add_child(click_player)
	
func play_music(path: String):
	if current_music == path:
		return # evita reiniciar la misma música
	
	current_music = path
	music_player.stream = load(path)
	music_player.play()
	
func play_hover():
		hover_player.play()

func play_click():
	click_player.play()
	
func toggle_music():
	var bus = AudioServer.get_bus_index("Musica")
	music_muted = !music_muted
	AudioServer.set_bus_mute(bus, music_muted)

func toggle_sfx():
	var bus = AudioServer.get_bus_index("SFX")
	sfx_muted = !sfx_muted
	AudioServer.set_bus_mute(bus, sfx_muted)
