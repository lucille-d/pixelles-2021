extends Area2D

onready var sprite = $Sprite
onready var outline = $Outline
onready var sound = $AudioStreamPlayer2D
onready var animation_player = $AnimationPlayer
onready var game = get_parent().get_parent()

var chaos_value = 10
var is_cleanable = true

func _ready():
	modulate_color()
	sound.play()
	if game and game.has_method("update_chaos"):
		game.update_chaos(chaos_value)

	var random_rotation = randi() % 4
	rotation_degrees = 90 * random_rotation
	print(str(random_rotation) + " " + str(rotation_degrees))

func on_clean():
	if not is_cleanable: return # used for tutorial
	animation_player.play("disappear")

func on_cleaned():
	if game and game.has_method("update_chaos"):
		game.update_chaos(-chaos_value)
		game.on_slime_cleaned()
	queue_free()

func modulate_color():
	sprite.modulate = Global.accent_color

func _on_Goo_body_entered(body):
	outline.show()
	body.add_nearby_goo(self)

func _on_Goo_body_exited(body):
	outline.hide()
	body.remove_nearby_goo(self)
	body.on_done_cleaning(true) # cancel cleaning
	animation_player.stop()
	sprite.self_modulate.a = 1
