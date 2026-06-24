extends CharacterBody2D

@export var respawn_grace_time := 0.35
var is_respawning := false

@export var speed: float = 400.0

@export var jump_velocity: float = -700.0

@export var gravedad: float = 900.0

@export var coyote_time: float = 0.12

var coyote_timer: float = 0.0
var interact_target: Area2D = null
var is_locked := false
var can_move := true
var was_on_floor := false

var is_dead := false
var original_layer : int
var original_mask : int

@export var fall_multiplier: float = 1.5
@export var low_jump_multiplier: float = 2.0

func can_die() -> bool:
	return not is_dead and not is_respawning

func _ready():
	original_layer = collision_layer
	original_mask = collision_mask

func reset_state():
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("idle")

func respawn_at(pos: Vector2):
	is_respawning = true

	global_position = pos

	is_dead = false
	can_move = true
	collision_layer = original_layer
	collision_mask = original_mask
	set_physics_process(true)

	reset_state()

	await get_tree().create_timer(respawn_grace_time).timeout

	is_respawning = false
	set_platform_indicator_enabled(true)

func take_damage():
	checkpoint_manager.respawn_player(self)

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	# --- COYOTE TIME ---
	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta

	# --- GRAVEDAD ---
	if velocity.y > 0:
		# cayendo
		velocity.y += gravedad * fall_multiplier * delta
		velocity.y += gravedad * delta

	else:
		velocity.y += gravedad * delta
	# --- SALTO ---
	if can_move and Input.is_action_just_pressed("ui_accept") and coyote_timer > 0:
		velocity.y = jump_velocity
		coyote_timer = 0
		#Saltar.play()
	# --- MOVIMIENTO HORIZONTAL ---
	var direction := 0
	if can_move:
		direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	# --- FLIP ---
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction < 0:
		$AnimatedSprite2D.flip_h = true

	# --- ANIMACIONES ---
	if is_on_floor():
		if direction != 0:
			play_anim("run")
		else:
			play_anim("idle")
	else:
		if velocity.y < 0:
			play_anim("jump")   # SIEMPRE al subir
		else:
			play_anim("fall")   # SIEMPRE al bajar

	if can_move and Input.is_action_just_pressed("interact"):
		for area in $Interactuador.get_overlapping_areas():
			if area.is_in_group("interactable"):
				area.press()
				break



	move_and_slide()
	if is_on_floor() and not was_on_floor:
		$Aterrizar.play()
	was_on_floor = is_on_floor()

func play_anim(name: String):
	if $AnimatedSprite2D.animation != name:
		$AnimatedSprite2D.play(name)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_dead or is_respawning:
		return


	if body.is_in_group("Rigidbody"):
		body.collision_layer = 1
		body.collision_mask = 1


func _on_area_2d_body_exited(body: Node2D) -> void:
	if is_dead or is_respawning:
		return

	if body.is_in_group("corpse"):
		return

	if body.is_in_group("Rigidbody"):
		body.collision_layer = 2
		body.collision_mask = 2


func lock():
	is_locked = true
	velocity = Vector2.ZERO
	set_physics_process(false)

func _on_animated_sprite_2d_frame_changed() -> void:
	var last_step_frame := -1
	if $AnimatedSprite2D.animation == "run":
		var f = $AnimatedSprite2D.frame
		
		if (f == 0 or f == 3) and f != last_step_frame:
			last_step_frame = f
			play_footstep()
			
func play_footstep():
	$Correr.pitch_scale = randf_range(0.92, 1.08)
	$Correr.play()

func die(death_type: int, spawn_corpse: bool = true):
	if is_dead:
		return

	is_dead = true
	can_move = false
	velocity = Vector2.ZERO

	collision_layer = 0
	collision_mask = 0
	set_platform_indicator_enabled(false)

	set_physics_process(false)

	play_death_animation(death_type)

	checkpoint_manager.start_death_sequence(self, death_type, spawn_corpse)

func play_death_animation(death_type: int):
	var anim_name := "GENERICO"

	match death_type:
		DeathTypes.DeathType.CONGELADO:
			anim_name = "CONGELADO"
		DeathTypes.DeathType.ELECTROCUTADO:
			anim_name = "ELECTROCUTADO"
		DeathTypes.DeathType.FUEGO:
			anim_name = "FUEGO"
		DeathTypes.DeathType.CLAVADO:
			anim_name = "CLAVADO"
		DeathTypes.DeathType.AHOGADO:
			anim_name = "AHOGADO"
		_:
			anim_name = "GENERICO"

	if $AnimatedSprite2D.sprite_frames.has_animation(anim_name):
		$AnimatedSprite2D.play(anim_name)
	else:
		print("No existe la animación de muerte: ", anim_name)
		$AnimatedSprite2D.play("GENERICO")

func set_platform_indicator_enabled(enabled: bool) -> void:
	if has_node("Indicador de plataforma"):
		var area := $"Indicador de plataforma"
		area.set_deferred("monitoring", enabled)
		area.set_deferred("monitorable", enabled)

		for child in area.get_children():
			if child is CollisionShape2D:
				child.set_deferred("disabled", not enabled)
