extends Control

onready var label = $VBoxContainer/Label

func _ready():
	label.text = "You made it!" if Global.has_won else "Slime is everywhere... You lost!"

func _on_RestartButton_pressed():
	Global.start_game()

func _on_MenuButton_pressed():
	Global.to_menu()
