extends TileMap

onready var noise_texture = $Sprite
onready var tileset = preload("res://assets/resources/element_tileset.tres")

# TODO
# variable width/height
# fence around all of it
# more wall-y?

var level_width = 20
var level_height = 14

func _ready():
	var noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 3
	noise.period = .1
	noise.persistence = 0
	noise_texture.texture.noise = noise

	var tomb_tile = tileset.find_tile_by_name("small_tomb")
	var light_tile = tileset.find_tile_by_name("light")
	for x in level_width:
		for y in level_height:
			if noise.get_noise_2d(float(x),float(y)) > 0.25:
				set_cell(x, y, light_tile if randf() > .9 else tomb_tile)




