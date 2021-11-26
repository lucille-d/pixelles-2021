extends Control

onready var game_mode_label = $VBoxContainer/HBoxContainer/GameModeLabel

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
