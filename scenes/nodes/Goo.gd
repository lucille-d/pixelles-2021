extends Area2D

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var game = get_parent().get_parent()

var chaos_value = 10
var is_cleanable = true

func _ready():
	modulate_color()
	if game and game.has_method("update_chaos"):
		game.update_chaos(chaos_value)

func on_clean():
	if not is_cleanable: return # used for tutorial
	animation_player.play("disappear")

func on_cleaned():
	if game and game.has_method("update_chaos"):
		game.update_chaos(-chaos_value)
	queue_free()

func modulate_color():
	sprite.modulate = Global.accent_color

func _on_Goo_body_entered(body):
	animation_player.play("blink")
	body.nearby_goo = self

func _on_Goo_body_exited(body):
	body.on_done_cleaning() # cancel cleaning
	animation_player.stop()
	sprite.self_modulate.a = 1
