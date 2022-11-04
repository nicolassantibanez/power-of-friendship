extends KinematicBody2D

const DOUBLE_PRESS_TIMEOUT = 0.3 # Timeout between key presses
const MAX_KEY_PRESSES = 2

var SPEED = 300
var ACCELERATION = 10000

export (int) var player_control = 1

var projectile_path = preload("res://scenes/basic_projectile.tscn")
var velocity = Vector2()
var last_key_delta = 0    # Time since last keypress
var key_combo = []        # Current combo
var key_actions: Dictionary = {
	"left": "wasd_left",
	"right": "wasd_right",
	"up": "wasd_up",
	"down": "wasd_down",
}
var move_input: Vector2 = Vector2(0,0)

onready var projectile_spawn = $projectileSpawn
onready var sprite = $Sprite


func _ready():
	if player_control != 1:
		key_actions.left = "arrow_left"
		key_actions.right = "arrow_right"
		key_actions.up = "arrow_up"
		key_actions.down = "arrow_down"
		sprite.self_modulate = Color.green

func _physics_process(delta):
	if Input.is_action_just_pressed(key_actions.left) or Input.is_action_just_pressed(key_actions.right)\
		or Input.is_action_just_pressed(key_actions.up) or Input.is_action_just_pressed(key_actions.down):
		if last_key_delta > DOUBLE_PRESS_TIMEOUT:                   # Reset combo if stale
			key_combo = []
		
		var action_pressed = ""
		if Input.is_action_just_pressed(key_actions.left):
			action_pressed = key_actions.left
		elif Input.is_action_just_pressed(key_actions.right):
			action_pressed = key_actions.right
		elif Input.is_action_just_pressed(key_actions.up):
			action_pressed = key_actions.up
		elif Input.is_action_just_pressed(key_actions.down):
			action_pressed = key_actions.down

		key_combo.append(action_pressed)
		if key_combo.size() > MAX_KEY_PRESSES:               # Prune if necessary
			key_combo.pop_front()

		print(key_combo) # Log the combo (could pass to combo evaluator)			
		last_key_delta = 0      # Reset keypress timer
		
		if len(key_combo) == MAX_KEY_PRESSES and key_combo[0] == key_combo[1]:
			if Input.is_action_just_pressed(key_actions.left):
				attack(Vector2(-1, 0))
			elif Input.is_action_just_pressed(key_actions.right):
				attack(Vector2(1, 0))
			elif Input.is_action_just_pressed(key_actions.up):
				attack(Vector2(0, -1))
			elif Input.is_action_just_pressed(key_actions.down):
				attack(Vector2(0, 1))
			return
		
	velocity = move_and_slide(velocity, Vector2.UP)
	var move_input = Vector2(
		Input.get_axis(key_actions.left, key_actions.right),
		Input.get_axis(key_actions.up, key_actions.down)
	).normalized()

	velocity = velocity.move_toward(move_input * SPEED, ACCELERATION * delta)
	
	last_key_delta += delta


func attack(direction:Vector2):
	projectile_spawn.look_at(direction + global_position)
	var projectile = projectile_path.instance()
	get_parent().add_child(projectile)
	projectile.position = $projectileSpawn/Sprite.global_position
	print(projectile.position)
	projectile.move_direction = direction
	print(direction)
