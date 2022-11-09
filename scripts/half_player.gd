class_name HalfPlayer

extends KinematicBody2D

# Constants variables
const SPEED = 300
const ACCELERATION = 10000

# Exported variables

# Public variables
var velocity = Vector2()

# Private variables
var _can_move = true
var _projectile_path = preload("res://scenes/basic_projectile.tscn")

# Onready variables
onready var shoot_spawn = $ShootPivot/ShootSpawn
onready var shoot_pivot = $ShootPivot


func _process(delta):
	if Input.is_action_just_pressed("arrow_left"):
		shoot(Vector2(-1, 0))
	elif Input.is_action_just_pressed("arrow_right"):
		shoot(Vector2(1, 0))
	elif Input.is_action_just_pressed("arrow_up"):
		shoot(Vector2(0, -1))
	elif Input.is_action_just_pressed("arrow_down"):
		shoot(Vector2(0, 1))

func _physics_process(delta):
	if _can_move == true:
		_move(delta)


func set_allow_movement(value:bool):
	self._can_move = value


func _move(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var move_input = Vector2(
		Input.get_axis("wasd_left", "wasd_right"),
		Input.get_axis("wasd_up", "wasd_down")
	).normalized()

	velocity = velocity.move_toward(move_input * SPEED, ACCELERATION * delta)


func shoot(direction:Vector2):
	shoot_pivot.look_at(direction + global_position)
	var projectile = self._projectile_path.instance()
	get_parent().add_child(projectile)
	projectile.position = shoot_spawn.global_position
	projectile.move_direction = direction
