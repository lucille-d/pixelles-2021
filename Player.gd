extends KinematicBody2D

onready var flashlight = $Flashlight
onready var flashlight_collider = $Flashlight/CollisionPolygon2D
onready var flashlight_light = $Flashlight/Light

const SPEED = 300

# reference casting points (pointing right)
const RC_POINTS = [Vector2(150,-40), Vector2(165,-20), Vector2(170,0), Vector2(165,20), Vector2(150,40)]

var move_vector = Vector2.ZERO
var is_flashlight_on = false
var light_casts : Array = []

func _ready():
	toggle_flashlight(is_flashlight_on)
	light_casts = get_tree().get_nodes_in_group('light')

	for i in light_casts.size():
		light_casts[i].cast_to = RC_POINTS[i]

func _process(delta):
	# movement
	move_vector = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		move_vector += Vector2.UP
	if Input.is_action_pressed("move_down"):
		move_vector += Vector2.DOWN
	if Input.is_action_pressed("move_left"):
		move_vector += Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		move_vector += Vector2.RIGHT

	move_vector = move_vector.normalized()

	# flashlight
	if Input.is_action_just_pressed("activate_light"):
		is_flashlight_on = !is_flashlight_on
		toggle_flashlight(is_flashlight_on)

	var polygon_points = null
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
	move_and_collide(move_vector * SPEED * delta)

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
		body.queue_free()
