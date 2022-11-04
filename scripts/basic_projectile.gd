extends Area2D

var SPEED = 600

var move_direction = Vector2(0,0)


func _ready():
	connect("body_entered", self, "_on_body_entered")


func _process(delta):
	position += SPEED * move_direction * delta


func on_timer_timeot():
	pass
#	queue_free()


func _on_body_entered(body: Node):
	if body.has_method("take_damage"):
		body.take_damage()
		queue_free()
