extends Area2D

var SPEED = 300

var move_direction = Vector2(0,0)


func _ready():
	connect("body_entered", self, "_on_body_entered")
	
func on_timer_timeot():
	queue_free()
	
func _on_body_entered(body: Node):
	# Por ahora al chocar desaparece xd
	queue_free()
