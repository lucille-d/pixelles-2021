extends Control

onready var game_mode_label = $VBoxContainer/HBoxContainer/GameModeLabel
onready var game_mode_sub_label = $VBoxContainer/GameModeSublabel

func _ready():
	update_game_mode_label()

func _on_LeftArrow_pressed():
	toggle_game_mode()

func _on_RightArrow_pressed():
	toggle_game_mode()

func toggle_game_mode():
	if Global.game_mode == 2:
		Global.game_mode = 1
	else:
		Global.game_mode = 2
	update_game_mode_label()

func update_game_mode_label():
	game_mode_label.text = "Timed" if Global.game_mode == 1 else "Infinite"
	game_mode_sub_label.text = "Clean as much slime as you can in 60 seconds!" if Global.game_mode == 1 else "Hold on as long as you can without drowning in slime!"
