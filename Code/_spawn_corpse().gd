func _emit_death_debug(death_type):
	match death_type:
		DeathTypes.DeathType.CONGELADO:
			print("El jugador se congeló ❄️")
		DeathTypes.DeathType.ELECTROCUTADO:
			print("El jugador fue electrocutado ⚡")
		DeathTypes.DeathType.AHOGADO:
			print("El jugador se ahogó")
		_:
			print("El jugador murió 💀")
