extends Control

onready var label = $VBoxContainer/Label
onready var time_label = $VBoxContainer/TimeLabel

func _ready():
	if Global.has_won:
		label.text = "You made it!"
	else:
		label.text = "Slime is everywhere... You lost!"
		time_label.text = "Time: " + str(floor(Global.finish_time)) + " seconds"
		time_label.show()
