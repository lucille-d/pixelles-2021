extends RigidBody2D

onready var Goo = preload("Goo.tscn")

onready var sprite = $Sprite
onready var anim_player = $AnimationPlayer
onready var goo_container = get_parent().find_node("GooContainer")

const SPEED = 50
export(int, "Vertical", "Horizontal") var direction

var is_killable = true
var facing = 1
var dying = false
var goo_timer = randi() % 4 + 2

func _process(delta):
	if dying: return

	goo_timer -= delta
	if goo_timer <= 0:
		spawn_goo()
		goo_timer = randi() % 4 + 2

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
	if not is_killable: return # used for tutorial
	dying = true
	anim_player.play("die")

func spawn_goo():
	var g = Goo.instance()
	g.position = position
	goo_container.add_child(g)
	return g
