extends Node2D

# Onready variables
onready var main_player = $YSort/MainPlayer
onready var secondary_player = $YSort/SecondaryPlayer

func _process(delta):
	if Input.is_action_pressed("dettach"):
		secondary_player.set_allow_movement(false)
	else:
		secondary_player.set_allow_movement(true)
