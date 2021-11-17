extends Node2D

onready var Ghost = preload("../nodes/Ghost.tscn")
onready var ui_timebar = $GUI/TimeBar
onready var ui_chaosbar = $GUI/ChaosBar
onready var goo_container = $GooContainer
onready var pause_overlay = $GUI/PauseOverlay

var ghost_spawn_timer = 0

const LEVEL_TIME = 60 # seconds
var current_time = 0

const MAX_CHAOS = 100
var current_chaos = 0

func _ready():
	Global.connect("pause", self, "on_pause")

func _process(delta):
	current_time += delta
	ui_timebar.value = min(100, current_time * 100 / LEVEL_TIME)

	if current_time >= LEVEL_TIME:
		Global.end_game(true)

	ghost_spawn_timer -= delta
	if ghost_spawn_timer <= 0:
		spawn_ghost()
		ghost_spawn_timer = randi() % 4 + 2

func update_chaos(value):
	current_chaos = max(0, current_chaos + value)

	ui_chaosbar.value = min(100, current_chaos * 100 / MAX_CHAOS)

	if current_chaos > MAX_CHAOS:
		Global.end_game(false)

func spawn_ghost():
	var g = Ghost.instance()
	g.position.x = randi() % 350
	g.position.y = randi() % 250
	if randf() > .5:
		g.direction = 1
	add_child(g)

func on_pause(is_paused):
	if is_paused:
		pause_overlay.show()
	else:
		pause_overlay.hide()
