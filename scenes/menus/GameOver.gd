extends Control

onready var label = $VBoxContainer/Label
onready var time_label = $VBoxContainer/TimeLabel
onready var record_label = $VBoxContainer/RecordLabel

func _ready():
	if Global.game_mode == 1 and Global.has_won:
		label.text = "You made it!"
	else:
		label.text = "Slime is everywhere... It's over!"
		time_label.text = "Time: " + str(floor(Global.finish_time)) + " seconds"
		time_label.show()

	if Global.game_mode == 2 and Global.new_record:
		record_label.modulate = Global.accent_color
		record_label.show()
