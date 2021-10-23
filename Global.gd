extends Node

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	if Input.is_action_just_pressed("restart"):
		restart()

	if Input.is_action_just_pressed("pause"):
		var is_paused = get_tree().paused
		get_tree().paused = !is_paused


func restart():
	get_tree().reload_current_scene()
#
#func restart_level():
#	to_level(current_level)
#
#func next_level():
#	if current_level == NUMBER_OF_LEVELS:
#		get_tree().change_scene_to(VictoryScene)
#	else:
#		current_level += 1
#		to_level(current_level)
#
#func game_over():
#	get_tree().change_scene_to(GameOverScene)
#
#func to_level(level_number):
#	current_level = level_number
#	get_tree().change_scene("res://levels/Level" + str(level_number) + ".tscn")
#
#func to_menu():
#	get_tree().change_scene_to(MenuScene)
