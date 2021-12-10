extends Node

signal pause

onready var GameScene = preload("res://scenes/levels/Game.tscn")
onready var TutorialScene = preload("res://scenes/levels/Tutorial.tscn")
onready var GameOverScene = preload("res://scenes/menus/GameOver.tscn")
onready var MenuScene = preload("res://scenes/menus/Menu.tscn")
onready var SettingsScene = preload("res://scenes/menus/Settings.tscn")

var game_mode = 1 # 1 = 60 secondes, 2 = infinite

var has_won = true
var new_record = true
# mode 1 = slime attack
var finish_slime = -1
var best_slime = -1
# mode 2 = infinite
var finish_time = -1
var best_time = -1

const DEFAULT_ACCENT_COLOR = Color("#00ff1b")
var accent_color = DEFAULT_ACCENT_COLOR

func _ready():
	pause_mode = PAUSE_MODE_PROCESS

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		quit()

	if Input.is_action_just_pressed("restart"):
		restart()

	if Input.is_action_just_pressed("pause"):
		var is_paused = get_tree().paused
		set_pause(!is_paused)

func start_game():
	get_tree().change_scene_to(GameScene)

func set_pause(value):
	get_tree().paused = value
	emit_signal("pause", value)

func to_tutorial():
	get_tree().change_scene_to(TutorialScene)

func end_game(win, time, slime_count):
	has_won = win
	finish_time = floor(time)
	finish_slime = slime_count
	if Global.game_mode == 1 and finish_slime > best_slime:
		best_slime = finish_slime
		new_record = true
	elif Global.game_mode == 2 and finish_time > best_time:
		best_time = finish_time
		new_record = true
	else:
		new_record = false
	get_tree().change_scene_to(GameOverScene)

func to_menu():
	get_tree().change_scene_to(MenuScene)

func to_settings():
	get_tree().change_scene_to(SettingsScene)

func restart():
	get_tree().reload_current_scene()

func quit():
	get_tree().quit()
