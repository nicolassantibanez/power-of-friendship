extends KinematicBody2D

const DOUBLE_PRESS_TIMEOUT = 0.3 # Timeout between key presses
const MAX_KEY_PRESSES = 2

var SPEED = 300
var ACCELERATION = 10000

var projectile_path = preload("res://scenes/basic_projectile.tscn")
var velocity = Vector2()
var last_key_delta = 0    # Time since last keypress
var key_combo = []        # Current combo

onready var projectile_spawn = $projectileSpawn


func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	var move_input = Vector2(
		Input.get_axis("wasd_left", "wasd_right"),
		Input.get_axis("wasd_up", "wasd_down")
	).normalized()
	
	velocity = velocity.move_toward(move_input * SPEED, ACCELERATION * delta)
	
	last_key_delta += delta


func _input(event):
	if event is InputEventKey and event.pressed and !event.echo: # If distinct key press down
		if last_key_delta > DOUBLE_PRESS_TIMEOUT:                   # Reset combo if stale
			key_combo = []
	
		key_combo.append(event.scancode)   
		if key_combo.size() > MAX_KEY_PRESSES:               # Prune if necessary
			key_combo.pop_front()

		if len(key_combo) == MAX_KEY_PRESSES and key_combo[0] == key_combo[1]:
			if event.is_action_pressed("wasd_left"):
				attack(Vector2(-1, 0))
			elif event.is_action_pressed("wasd_right"):
				attack(Vector2(1, 0))
			elif event.is_action_pressed("wasd_up"):
				attack(Vector2(0, -1))
			elif event.is_action_pressed("wasd_down"):
				attack(Vector2(0, 1))
		
		print(key_combo) # Log the combo (could pass to combo evaluator)
		last_key_delta = 0      # Reset keypress timer

func attack(direction:Vector2):
	projectile_spawn.look_at(direction + global_position)
	var projectile = projectile_path.instance()
	get_parent().add_child(projectile)
	projectile.position = $projectileSpawn/Sprite.global_position
	print(projectile.position)
	projectile.move_direction = direction
	print(direction)
