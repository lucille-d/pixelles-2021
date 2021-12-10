extends Control

export var sprite_rect_x = 67
export var colored = false
export (int, "None", "Particles", "Shake") var animation_type = 0

onready var sprite = $Sprite
onready var bar = $Bar
onready var bar_fill = $BarFill
onready var particles = $Sprite/Particles2D
onready var anim_player = $AnimationPlayer

const MAX_SIZE = 74

var value = 0
var shaking = true

func _ready():
	sprite.region_rect.position.x = sprite_rect_x

	if colored:
		sprite.modulate = Global.accent_color
		bar_fill.modulate = Global.accent_color

func _process(_delta):
	bar_fill.rect_size.y = value * MAX_SIZE / 100

#	if Input.is_action_just_pressed("shoot_up"):
#		set_value(value + 10)
#	if Input.is_action_just_pressed("shoot_down"):
#		set_value(value - 10)

func set_value(new_value):
	var old_value = value
	value = new_value

	if animation_type == 1 and old_value < value:
		particles.emitting = true
	elif animation_type == 2 and value > 90:
		anim_player.play("shake")
