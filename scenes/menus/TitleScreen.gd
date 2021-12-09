extends Control

func _input(event):
	if event.is_pressed():
		Global.to_menu()
