class_name projectile

extends Area2D

# Constant variables
var SPEED = 600

# Public variables
var move_direction = Vector2(0,0)

# Private variables
var life_timer = Timer.new()

func _ready():
	add_child(life_timer)
	life_timer.wait_time = 0.5
	life_timer.one_shot = true
	life_timer.connect("timeout", self, "_on_life_timer_timeout")
	life_timer.start()
	connect("body_entered", self, "_on_body_entered")


func _process(delta):
	position += SPEED * move_direction * delta


func _on_life_timer_timeout():
	queue_free()


func _on_body_entered(body: Node):
	if body.has_method("take_damage"):
		body.take_damage()
		queue_free()
