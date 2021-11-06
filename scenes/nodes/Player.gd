extends KinematicBody2D

onready var sprite = $Sprite
onready var flashlight = $Flashlight
onready var flashlight_collider = $Flashlight/CollisionPolygon2D
onready var flashlight_light = $Flashlight/Light

const SPEED = 7000

# reference casting points (pointing right)
const MAX_X = 95
const MID_X = 90
const MIN_X = 80
const MAX_Y = 30
const MIN_Y = 15
const RC_POINTS = [Vector2(MIN_X,-MAX_Y), Vector2(MID_X,-MIN_Y), Vector2(MAX_X,0), Vector2(MID_X,MIN_Y), Vector2(80,MAX_Y)]

var move_vector = Vector2.ZERO
var is_flashlight_on = false
var light_casts : Array = []

func _ready():
	toggle_flashlight(is_flashlight_on)
	light_casts = get_tree().get_nodes_in_group('light')

	for i in light_casts.size():
		light_casts[i].cast_to = RC_POINTS[i]

func _process(_delta):
	# movement
	move_vector = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		sprite.region_rect.position.x = 16
		sprite.flip_h = false
		move_vector += Vector2.UP
	if Input.is_action_pressed("move_down"):
		sprite.region_rect.position.x = 0
		sprite.flip_h = false
		move_vector += Vector2.DOWN
	if Input.is_action_pressed("move_left"):
		sprite.region_rect.position.x = 32
		sprite.flip_h = true
		move_vector += Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		sprite.region_rect.position.x = 32
		sprite.flip_h = false
		move_vector += Vector2.RIGHT

	move_vector = move_vector.normalized()

	# flashlight
	if Input.is_action_just_pressed("activate_light"):
		is_flashlight_on = !is_flashlight_on
		toggle_flashlight(is_flashlight_on)

	var lc_rotation = null
	if Input.is_action_just_pressed("shoot_up"):
		lc_rotation = -90
	if Input.is_action_just_pressed("shoot_down"):
		lc_rotation = 90
	if Input.is_action_just_pressed("shoot_left"):
		lc_rotation = 180
	if Input.is_action_just_pressed("shoot_right"):
		lc_rotation = 0

	if lc_rotation != null:
		for i in light_casts.size():
			light_casts[i].cast_to = RC_POINTS[i].rotated(deg2rad(lc_rotation))

func _physics_process(delta):
	move_and_slide(move_vector * SPEED * delta)

	if is_flashlight_on:
		update_light_casts()

func toggle_flashlight(is_on): # TODO not the best name
	flashlight.visible = is_on
	flashlight_collider.disabled = !is_on
	for lc in light_casts:
		lc.enabled = is_on

func update_light_casts():
	var points = [Vector2.ZERO]
	for lc in light_casts:
		if lc.is_colliding():
			points.append(to_local(lc.get_collision_point()))
		else:
			points.append(to_local(to_global(lc.cast_to)))
	flashlight_collider.polygon = PoolVector2Array(points)
	flashlight_light.polygon = PoolVector2Array(points)

func _on_Flashlight_body_entered(body):
	if "Ghost" in body.name:
		body.hit_by_light()
#		body.queue_free()
