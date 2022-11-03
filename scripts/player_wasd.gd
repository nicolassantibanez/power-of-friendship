extends KinematicBody2D

var SPEED = 200
var ACCELERATION = 1000

var projectile = preload("res://scenes/basic_projectile.tscn")
var velocity = Vector2()

onready var projectile_spanw = $projectileSpawn
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var move_input = Vector2(
		Input.get_axis("wasd_left", "wasd_right"),
		Input.get_axis("wasd_up", "wasd_down")
	).normalized()
	
	velocity = velocity.move_toward(move_input * SPEED, ACCELERATION * delta)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
