extends RigidBody2D

onready var sprite = $Sprite

const SPEED = 50
export(int, "Vertical", "Horizontal") var direction

var facing = 1

func _process(delta):
	if direction == 1:
		sprite.region_rect.position.x = 32
		position.x = position.x + SPEED * delta * facing
		if position.x > 200:
			sprite.flip_h = true
			facing = -1
		if position.x < 20:
			sprite.flip_h = false
			facing = 1

	else:
		position.y = position.y + SPEED * delta * facing
		if position.y > 150:
			sprite.region_rect.position.x = 16
			facing = -1
		if position.y < 20:
			sprite.region_rect.position.x = 0
			facing = 1
