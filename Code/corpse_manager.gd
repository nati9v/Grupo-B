extends Node

@export var max_corpses := 5

@export var corpse_fuego: PackedScene
@export var corpse_electro: PackedScene
@export var corpse_hielo: PackedScene
@export var corpse_default: PackedScene

@export var delay_fuego := 1.0
@export var delay_electro := 0.2
@export var delay_hielo := 0.5
@export var delay_default := 0.3

var corpses: Array = []

func spawn_corpse(position: Vector2, death_type):
	var scene_to_spawn: PackedScene
	var delay := 0.0

	match death_type:
		DeathTypes.DeathType.FUEGO:
			scene_to_spawn = corpse_fuego
			delay = delay_fuego
		DeathTypes.DeathType.ELECTROCUTADO:
			scene_to_spawn = corpse_electro
			delay = delay_electro
		DeathTypes.DeathType.CONGELADO:
			scene_to_spawn = corpse_hielo
			delay = delay_hielo
		_:
			scene_to_spawn = corpse_default
			delay = delay_default

	_spawn_with_delay(scene_to_spawn, position, delay)


func _spawn_with_delay(scene: PackedScene, pos: Vector2, delay: float) -> void:
	await get_tree().create_timer(delay).timeout

	if scene == null:
		return

	var corpse = scene.instantiate()
	corpse.global_position = pos
	get_tree().current_scene.add_child(corpse)

	corpses.append(corpse)

	if corpses.size() > max_corpses:
		var oldest = corpses.pop_front()
		if is_instance_valid(oldest):
			oldest.queue_free()
