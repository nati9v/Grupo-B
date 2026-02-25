extends Node2D

var is_frozen := false

func _ready():
	# El hielo empieza desactivado
	$IceFloor/CollisionShape2D.set_deferred("disabled", true)
	
	$IceSprite.visible = false
	$WaterSprite.visible = true


func _on_detector_de_cadaver_body_entered(body: Node2D) -> void:

	if is_frozen:
		return

	if body is RigidBody2D and body.is_in_group("congelado"):
		freeze_water()


func freeze_water(propagated := false):

	if is_frozen:
		return

	is_frozen = true

	$Zonademuerte.monitoring = false
	$IceFloor/CollisionShape2D.set_deferred("disabled", false)
	$WaterSprite.visible = false
	$IceSprite.visible = true

	# Si no viene de propagación, avisamos a vecinos
	if not propagated:
		propagate_freeze()

func propagate_freeze() -> void:

	var traps = []

	for trap in get_tree().get_nodes_in_group("water_traps"):

		if trap == self:
			continue

		if trap.has_method("freeze_water"):
			var dist = global_position.distance_to(trap.global_position)
			if dist < 2500:
				traps.append({"node": trap, "dist": dist})

	traps.sort_custom(func(a, b): return a["dist"] < b["dist"])

	for data in traps:
		await get_tree().create_timer(0.5).timeout
		data["node"].freeze_water(true)
