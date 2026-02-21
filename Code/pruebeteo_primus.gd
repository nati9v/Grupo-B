extends CharacterBody2D

@export var speed: float = 400.0
@export var jump_velocity: float = -700.0
@export var gravedad: float = 900.0

@export var coyote_time: float = 0.12
var coyote_timer: float = 0.0
var interact_target: Area2D = null

@export var fall_multiplier: float = 1.5
@export var low_jump_multiplier: float = 2.0

func reset_state():
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("idle")

func respawn_at(pos: Vector2):
	global_position = pos
	reset_state()

func take_damage():
	checkpoint_manager.respawn_player(self)

func _physics_process(delta: float) -> void:
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
	if Input.is_action_just_pressed("ui_accept") and coyote_timer > 0:
		velocity.y = jump_velocity
		coyote_timer = 0

	# --- MOVIMIENTO HORIZONTAL ---
	var direction := Input.get_axis("ui_left", "ui_right")
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

	if Input.is_action_just_pressed("interact"):
		for area in $Interactuador.get_overlapping_areas():
			if area.is_in_group("interactable"):
				area.press()
				break



	move_and_slide()

func play_anim(name: String):
	if $AnimatedSprite2D.animation != name:
		$AnimatedSprite2D.play(name)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Rigidbody"):
		print("contacto")
		body.collision_layer = 1
		body.collision_mask = 1

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Rigidbody"):
		print("desconectado")
		body.collision_layer = 2
		body.collision_mask = 2
