extends Control

onready var label = $VBoxContainer/Label

func _ready():
	label.text = "You made it!" if Global.has_won else "Slime is everywhere... You lost!"
