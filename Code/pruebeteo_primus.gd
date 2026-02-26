extends CharacterBody2D

@export var speed: float = 400.0

@export var jump_velocity: float = -700.0

@export var gravedad: float = 900.0

@export var coyote_time: float = 0.12

var coyote_timer: float = 0.0
var interact_target: Area2D = null
var is_locked := false
var can_move := true
var was_on_floor := false

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
	if body.is_in_group("Rigidbody"):
		body.collision_layer = 1
		body.collision_mask = 1

func _on_area_2d_body_exited(body: Node2D) -> void:
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
