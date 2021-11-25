extends TileMap

onready var noise_texture = $Sprite
onready var tileset = preload("res://assets/resources/element_tileset.tres")
onready var flame_particles = preload("res://assets/resources/flames_particlesmaterial.tres")

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
			if x == y and x == 2: continue # player spawn position
			if noise.get_noise_2d(float(x),float(y)) > 0.3:
				if randf() <= .9:
					set_cell(x, y, tomb_tile)
				else:
					set_cell(x, y, light_tile)
					var p = Particles2D.new()
					p.process_material = flame_particles
					p.amount = 40
					p.lifetime = .5
					p.preprocess = 2
					p.randomness = 1
					p.modulate = Global.accent_color
					p.position = Vector2(x * 16 + 8, y * 16 + 3)
					add_child(p)




