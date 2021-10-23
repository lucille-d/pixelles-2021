extends RigidBody2D

const SPEED = 150

var direction = 1

func _process(delta):
	position.y = position.y + SPEED * delta * direction
	if position.y > 400:
		direction = -1
	if position.y < 100:
		direction = 1

