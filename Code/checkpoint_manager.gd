extends Node

signal player_died(death_type)

var last_checkpoint_position: Vector2
var has_checkpoint := false

func set_checkpoint(pos: Vector2):
	last_checkpoint_position = pos
	has_checkpoint = true

func handle_death(player: Node2D, death_type, spawn_corpse: bool):
	_emit_death_debug(death_type)

	if spawn_corpse:
		_spawn_corpse(player.global_position, death_type)

	respawn_player(player)

func respawn_player(player: Node2D):
	if has_checkpoint:
		player.respawn_at(last_checkpoint_position)

func _emit_death_debug(death_type):
	match death_type:
		DeathTypes.DeathType.CONGELADO:
			print("El jugador se congeló ❄️")
		DeathTypes.DeathType.ELECTROCUTADO:
			print("El jugador fue electrocutado ⚡")
		DeathTypes.DeathType.FUEGO:
			print("El jugador se quemó 🔥")
		_:
			print("El jugador murió 💀")

func _spawn_corpse(pos: Vector2, death_type):
	for trap in get_tree().get_nodes_in_group("death_zone"):
		trap.reactivate()
	CorpseManager.spawn_corpse(pos, death_type)
