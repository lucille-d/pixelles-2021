extends Node2D

onready var label = $CanvasLayer/Panel/Label
onready var enter_label = $CanvasLayer/Panel/EnterLabel
onready var ui_time_bar = $CanvasLayer/TimeBar
onready var ui_slime_bar = $CanvasLayer/ChaosBar
onready var Ghost = preload("../nodes/Ghost.tscn")

var current_step = 1
var movement_pressed = []
var g = null
var s = null

func _ready():
	ui_slime_bar.value = 50
	ui_time_bar.value = 50

func _process(delta):
	if current_step:
		call("process_step_" + str(current_step))

func process_step_1():
	if Input.is_action_pressed("move_up") and not movement_pressed.has("move_up"):
		movement_pressed.append("move_up")
	if Input.is_action_pressed("move_down") and not movement_pressed.has("move_down"):
		movement_pressed.append("move_down")
	if Input.is_action_pressed("move_left") and not movement_pressed.has("move_left"):
		movement_pressed.append("move_left")
	if Input.is_action_pressed("move_right") and not movement_pressed.has("move_right"):
		movement_pressed.append("move_right")

	if Input.is_action_just_pressed("ui_accept") or movement_pressed.size() >= 4:
		g = Ghost.instance()
		g.position = Vector2(60,100)
		g.direction = 1
		g.goo_timer = INF
		g.is_killable = false
		add_child(g)
		label.text = "Ghosts will appear around you..."
		enter_label.show()
		current_step = 2

func process_step_2():
	if Input.is_action_just_pressed("ui_accept"):
		label.text = "They won't hurt you, but they make a mess!"
		s = g.spawn_goo()
		s.is_cleanable = false
		current_step = 3

func process_step_3():
	if Input.is_action_just_pressed("ui_accept"):
		enter_label.hide()
		label.text = "You can clean the slime by pressing E when near it."
		s.connect("tree_exited", self, "clean_slime_done")
		s.is_cleanable = true
		current_step = null

func clean_slime_done():
	g.connect("tree_exited", self, "kill_ghost_done")
	label.text = "You can also get rid of ghosts with your flashlight [F + Arrow keys]."
	g.is_killable = true

func kill_ghost_done():
	ui_slime_bar.show()
	label.text = "If the slime counter fills up, you lose..."
	enter_label.show()
	current_step = 4

func process_step_4():
	if Input.is_action_just_pressed("ui_accept"):
		ui_time_bar.show()
		label.text = "If you make it to the end of the timer, you win!"
		current_step += 1

func process_step_5():
	if Input.is_action_just_pressed("ui_accept"):
		label.text = "Good luck!"
		current_step += 1

func process_step_6():
	if Input.is_action_just_pressed("ui_accept"):
		Global.to_menu()

