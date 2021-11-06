extends Control

onready var sprite = $Sprite
onready var bar = $Bar
onready var bar_fill = $BarFill

export var sprite_rect_x = 67
export var colored = false

const MAX_SIZE = 74
var value = 0

func _ready():
	sprite.region_rect.position.x = sprite_rect_x
	
	if colored:
		sprite.modulate = Global.accent_color
		bar_fill.modulate = Global.accent_color

func _process(_delta):
	bar_fill.rect_size.y = value * MAX_SIZE / 100

