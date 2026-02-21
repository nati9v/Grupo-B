extends PointLight2D

@export var energiaNormal := 4.8
@export var minEnergia := 0.0
@export var titilar := 2

var tiempo := 0.0

func _process(delta):
	tiempo -= delta
	
	if tiempo <= 0:
		tiempo = randf_range(0.02, 0.15) # tiempo irregular
		
		var chance = randf()
		
		if chance < 0.15:
			# apagón fuerte
			energy = minEnergia
		elif chance < 0.4:
			# bajón fuerte
			energy = energiaNormal - titilar
		else:
			# casi normal
			energy = randf_range(energiaNormal - 0.1, energiaNormal + 0.05)
