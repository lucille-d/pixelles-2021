extends Node2D

onready var Ghost = preload("../nodes/Ghost.tscn")
onready var ui_timer = $GUI/Timer
onready var ui_timebar = $GUI/TimeBar
onready var ui_chaosbar = $GUI/ChaosBar
onready var goo_container = $GooContainer
onready var pause_overlay = $GUI/PauseOverlay

const MAX_GHOSTS = 5
var ghost_spawn_timer = 0
var ghost_counter = 0

const LEVEL_TIME = 60 # seconds
var current_time = 0
var current_difficulty = 1
const MAX_DIFFICULTY = 8
const DIFFICULTY_TIER  = 15 #LEVEL_TIME / MAX_DIFFICULTY

const MAX_CHAOS = 100
var current_chaos = 0

func _ready():
	Global.connect("pause", self, "on_pause")
	Global.set_pause(false)
	if Global.game_mode == 1:
		ui_timebar.show()
		ui_timer.hide()

func _process(delta):
	current_time += delta
	update_difficulty()
	ui_timebar.set_value(min(100, current_time * 100 / LEVEL_TIME))
	ui_timer.text = str(floor(current_time))

	if Global.game_mode == 1 and current_time >= LEVEL_TIME:
		Global.end_game(true, current_time)

	ghost_spawn_timer -= delta
	if ghost_spawn_timer <= 0:
		if ghost_counter < MAX_GHOSTS:
			spawn_ghost()
		ghost_spawn_timer = randi() % 4 + 2

func update_difficulty():
	if current_time > current_difficulty * DIFFICULTY_TIER:
		current_difficulty += 1

func update_chaos(value):
	current_chaos = max(0, current_chaos + value)

	ui_chaosbar.set_value(min(100, current_chaos * 100 / MAX_CHAOS))

	if current_chaos > MAX_CHAOS:
		Global.end_game(false, current_time)

func spawn_ghost():
	var g = Ghost.instance()
	g.position.x = randi() % 350
	g.position.y = randi() % 250
	g.connect("ghost_dead", self, "on_ghost_death")
	g.game = self
	if randf() > .5:
		g.direction = 1
	add_child(g)
	ghost_counter += 1

func on_ghost_death():
	ghost_counter -= 1

func on_pause(is_paused):
	if is_paused:
		pause_overlay.show()
	else:
		pause_overlay.hide()
