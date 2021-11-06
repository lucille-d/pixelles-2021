extends Node2D

onready var Goo = preload("nodes/Goo.tscn")
onready var ui_timebar = $GUI/TimeBar
onready var ui_chaosbar = $GUI/ChaosBar
onready var goo_container = $GooContainer

const LEVEL_TIME = 60 # seconds
var current_time = 0

const MAX_CHAOS = 100
var current_chaos = 0

func _process(delta):
	current_time += delta
	ui_timebar.value = min(100, current_time * 100 / LEVEL_TIME)
	
	if current_time >= LEVEL_TIME:
		Global.end_game(true)
		
	# REMOVE
	if Input.is_action_just_pressed("shoot_up"):
		update_chaos(10)
	if Input.is_action_just_pressed("shoot_down"):
		update_chaos(-10)
	if Input.is_action_just_pressed("shoot_left"):
		spawn_goo(Vector2(10,10))

func update_chaos(value):
	current_chaos = max(0, current_chaos + value)
	
	ui_chaosbar.value = min(100, current_chaos * 100 / MAX_CHAOS)
		
	if current_chaos > MAX_CHAOS:
		Global.end_game(false)
	
	
func spawn_goo(pos: Vector2):
	var g = Goo.instance()
	g.position = pos
	goo_container.add_child(g)
