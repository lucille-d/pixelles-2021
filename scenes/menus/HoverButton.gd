extends Button

export var global_method = "to_settings"

onready var sprite = $Sprite
onready var hover_sound = $HoverSound
onready var click_sound = $ClickSound

func _ready():
	pause_mode = PAUSE_MODE_PROCESS

func _on_HoverButton_mouse_entered():
	hover_sound.play()
	sprite.show()

func _on_HoverButton_mouse_exited():
	sprite.hide()


func _on_HoverButton_pressed():
	click_sound.play()

func _on_ClickSound_finished():
	Global.call(global_method)
