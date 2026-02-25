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

func get_delay_for_type(death_type) -> float:

	match death_type:
		DeathTypes.DeathType.CONGELADO:
			return delay_hielo
		DeathTypes.DeathType.ELECTROCUTADO:
			return delay_electro
		DeathTypes.DeathType.FUEGO:
			return delay_fuego
		_:
			return delay_default

var corpses: Array = []

func register_corpse(corpse_node: Node):
	corpses.append(corpse_node)
	emit_signal("corpse_count_changed", corpses.size())

	if corpses.size() > max_corpses:
		var oldest = corpses.pop_front()

		if is_instance_valid(oldest):

			var target = oldest

			if not target.has_method("remove_corpse_state"):
				target = target.get_parent()

			if target and target.has_method("remove_corpse_state"):
				target.remove_corpse_state()
			else:
				oldest.queue_free()

		emit_signal("corpse_count_changed", corpses.size())

signal corpse_count_changed(new_count)



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
	emit_signal("corpse_count_changed", corpses.size())

	if corpses.size() > max_corpses:
		var oldest = corpses.pop_front()
		if is_instance_valid(oldest):
			oldest.queue_free()
	emit_signal("corpse_count_changed", corpses.size())
