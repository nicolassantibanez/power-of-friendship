extends KinematicBody2D

class_name Enemy

func _physics_process(delta):
	var Player1 = get_parent().get_node("Player1")
	var Player2 = get_parent().get_node("Player2")
	
	if (Player1.position - position).length_squared() < (Player2.position - position).length_squared():
		position += (Player1.position - position) / 150
		look_at(Player1.position)
	else:
		position += (Player2.position - position) / 150
		look_at(Player2.position)

func _take_damage():
	print("Enemy: Auch!")

func _get_stun():
	print("I'm stunned!")

func _get_burn():
	print("I'm being burned!")
