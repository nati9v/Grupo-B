extends Node

var music_player: AudioStreamPlayer
var current_music: String = ""

var music_muted := false
var sfx_muted := false

func _ready():
	#crea un nuevo audio stream y le asigna el bus "Musica"
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Musica"
	add_child(music_player)

func play_music(path: String):
	if current_music == path:
		return # evita reiniciar la misma música
	
	current_music = path
	music_player.stream = load(path)
	music_player.play()

func toggle_music():
	var bus = AudioServer.get_bus_index("Musica")
	music_muted = !music_muted
	AudioServer.set_bus_mute(bus, music_muted)

func toggle_sfx():
	var bus = AudioServer.get_bus_index("SFX")
	sfx_muted = !sfx_muted
	AudioServer.set_bus_mute(bus, sfx_muted)
