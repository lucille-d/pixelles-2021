extends Control

onready var label = $VBoxContainer/Label
onready var result_label = $VBoxContainer/ResultLabel
onready var record_label = $VBoxContainer/RecordLabel

func _ready():
	if Global.game_mode == 1:
		label.text = "You're out of time!" if Global.has_won else "Slime is everywhere... It's over!"
		result_label.text = "" if Global.has_won else "You held on for " + str(Global.finish_time) + " seconds.\n"
		result_label.text += "Slime cleaned: " + str(Global.finish_slime)
		result_label.show()
	else:
		label.text = "Slime is everywhere... It's over!"
		result_label.text = "Time: " + str(Global.finish_time) + " seconds"
		result_label.show()

	if Global.new_record:
		record_label.modulate = Global.accent_color
		record_label.show()
