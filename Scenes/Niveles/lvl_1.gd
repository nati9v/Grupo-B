extends Node2D

@onready var player := $Pruebeteoprimus


func _ready():
	checkpoint_manager.set_checkpoint(player.global_position)
