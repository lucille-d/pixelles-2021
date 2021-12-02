extends Node

signal pause

onready var GameScene = preload("res://scenes/levels/Game.tscn")
onready var TutorialScene = preload("res://scenes/levels/Tutorial.tscn")
onready var GameOverScene = preload("res://scenes/menus/GameOver.tscn")
onready var MenuScene = preload("res://scenes/menus/Menu.tscn")
onready var SettingsScene = preload("res://scenes/menus/Settings.tscn")

var game_mode = 2 # 1 = 60 secondes, 2 = infinite

var has_won = true
var finish_time = -1
var best_time = -1
var new_record = true

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

func end_game(win, time):
	has_won = win
	finish_time = floor(time)
	if Global.game_mode == 2 and finish_time > best_time:
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
