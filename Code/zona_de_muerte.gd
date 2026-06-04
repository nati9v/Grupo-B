extends Area2D

enum ActivationMode {
	ALWAYS_ON,
	BUTTON,
	TIMER
}

@export var activation_mode : ActivationMode = ActivationMode.ALWAYS_ON
@export var death_type: int = DeathTypes.DeathType.GENERICO
@export var spawn_corpse: bool = true

@export var active_time := 1.5
@export var cooldown_time := 2.0

var is_active := true


func _ready():
	match activation_mode:

		ActivationMode.ALWAYS_ON:
			is_active = true

		ActivationMode.BUTTON:
			is_active = false
			$CollisionShape2D.disabled = true
			$AnimatedSprite2D.play("default")
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.frame = 0

		ActivationMode.TIMER:
			is_active = false
			$CollisionShape2D.disabled = true
			start_cycle()


func _on_body_entered(body: Node2D) -> void:

	if not is_active:
		return

	if not body.is_in_group("player"):
		return
	
	if body.has_method("can_die") and not body.can_die():
		return
	
	_kill_player(body)
			#$ImpactoSFX.play()


func _kill_player(body: Node2D):

	if body.has_method("die"):
		body.die(death_type, spawn_corpse)

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


func activate():

	if activation_mode == ActivationMode.BUTTON:
		await get_tree().create_timer(0.5).timeout

	is_active = true
	$CollisionShape2D.disabled = false

	if has_node("AnimatedSprite2D"):
		$AnimatedSprite2D.play("default")

	for body in get_overlapping_bodies():
		if body.is_in_group("player"):
			_kill_player(body)

	if activation_mode == ActivationMode.BUTTON:
		await get_tree().create_timer(active_time).timeout
		deactivate()


func deactivate():
	is_active = false
	$CollisionShape2D.disabled = true

	if has_node("AnimatedSprite2D"):
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 0


func start_cycle():

	while true:
		activate()
		await get_tree().create_timer(active_time).timeout
		deactivate()
		await get_tree().create_timer(cooldown_time).timeout


func _on_animated_sprite_2d_animation_finished():
	if activation_mode == ActivationMode.BUTTON:
		deactivate()


func reactivate():
	if activation_mode == ActivationMode.ALWAYS_ON:
		is_active = true
		$CollisionShape2D.disabled = false
