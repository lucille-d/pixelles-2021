extends Area2D

onready var sprite = $Sprite
onready var game = get_parent().get_parent()

var chaos_value = 10

func _ready():
	sprite.modulate = Global.accent_color
	game.update_chaos(chaos_value)

func on_clean():
	game.update_chaos(-chaos_value)
	queue_free()
	
# TODO
# BLINK WHEN PLAYER IS CLOSE
# UP CHAOS METER ON CREATION
# DOWN CHAOS METER ON DELETE
# CLEANING TAKES A SECOND (HANDLED HERE OR ON PLAYER)


func _on_Goo_body_entered(body):
	print("PLAYER NEAR")
