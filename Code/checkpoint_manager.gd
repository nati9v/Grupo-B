extends Node

signal player_died(death_type)

var last_checkpoint_position: Vector2
var has_checkpoint := false

func set_checkpoint(pos: Vector2):
	last_checkpoint_position = pos
	has_checkpoint = true

func handle_death(player: Node2D, death_type, spawn_corpse: bool):

	_emit_death_debug(death_type)

	# 🔒 Bloquear jugador
	player.can_move = false
	player.velocity = Vector2.ZERO

	# 🎬 Animación según tipo
	var sprite = player.get_node("AnimatedSprite2D")

	match death_type:
		DeathTypes.DeathType.CONGELADO:
			sprite.play("congelado")
		DeathTypes.DeathType.ELECTROCUTADO:
			sprite.play("electrocutado")
		DeathTypes.DeathType.FUEGO:
			sprite.play("death_fire")
		DeathTypes.DeathType.CLAVADO:
			sprite.play("death_spike")
		_:
			sprite.play("death_default")

	# 💀 Spawn cadáver en posición actual
	if spawn_corpse:
		_spawn_corpse(player.global_position, death_type)

	# ⏳ Esperar delay según tipo + 1 segundo
	var delay = CorpseManager.get_delay_for_type(death_type)
	await get_tree().create_timer(delay + 1.0).timeout

	# 🔄 Respawn
	respawn_player(player)
	
	player.collision_layer = 1
	player.collision_mask = 1
	player.set_physics_process(true)

	player.can_move = true
	player.is_dead = false

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
	CorpseManager.spawn_corpse(pos, death_type)

func start_death_sequence(player: Node2D, death_type):

	_emit_death_debug(death_type)

	_spawn_corpse(player.global_position, death_type)

	var delay = CorpseManager.get_delay_for_type(death_type)

	await get_tree().create_timer(delay + 1.0).timeout

	respawn_player(player)

	player.can_move = true
	player.is_dead = false
