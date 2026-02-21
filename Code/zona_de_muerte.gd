extends Area2D

@export var death_type: int = DeathTypes.DeathType.GENERICO

@export var spawn_corpse: bool = true

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	print("Jugador murió por:", death_type)

	checkpoint_manager.handle_death(body, death_type, spawn_corpse)
	if get_parent().has_method("on_local_death"):
		get_parent().on_local_death()
	_handle_death_effect(body)


func _handle_death_effect(player: Node2D) -> void:
	match death_type:
		DeathTypes.DeathType.ELECTROCUTADO:
			print("⚡ Electrocución")

		DeathTypes.DeathType.FUEGO:
			print("🔥 Quemado")

		DeathTypes.DeathType.CONGELADO:
			print("❄️ Congelado")

		_:
			print("☠️ Muerte genérica")
