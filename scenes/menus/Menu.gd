extends Control

func _on_StartButton_pressed():
	Global.start_game()


func _on_SettingsButton_pressed():
	Global.to_settings()


func _on_TutorialButton_pressed():
	Global.to_tutorial()
