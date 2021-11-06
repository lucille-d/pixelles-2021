extends Control

onready var label = $VBoxContainer/Label

func _ready():
	label.text = "YAY" if Global.has_won else "NOOO"

func _on_RestartButton_pressed():
	Global.start_game()

func _on_MenuButton_pressed():
	Global.to_menu()
