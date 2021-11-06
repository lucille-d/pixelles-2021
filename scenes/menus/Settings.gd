extends Control

onready var color_picker = $ColorPicker

func _ready():
	color_picker.color = Global.accent_color

func _on_SaveButton_pressed():
	Global.accent_color = color_picker.color
	Global.to_menu()

func _on_ResetButton_pressed():
	color_picker.color = Global.DEFAULT_ACCENT_COLOR
