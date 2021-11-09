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

func update_chaos(value):
	current_chaos = max(0, current_chaos + value)

	ui_chaosbar.value = min(100, current_chaos * 100 / MAX_CHAOS)

	if current_chaos > MAX_CHAOS:
		Global.end_game(false)
