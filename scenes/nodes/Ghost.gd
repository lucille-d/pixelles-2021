extends RigidBody2D

onready var sprite = $Sprite
onready var anim_player = $AnimationPlayer

const SPEED = 50
export(int, "Vertical", "Horizontal") var direction

var facing = 1
var dying = false

func _process(delta):
	if dying: return

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

func hit_by_light():
	dying = true
	anim_player.play("die")
