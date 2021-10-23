extends RigidBody2D

const SPEED = 50

var direction = 1

func _process(delta):
	position.y = position.y + SPEED * delta * direction
	if position.y > 200:
		direction = -1
	if position.y < 20:
		direction = 1

