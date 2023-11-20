extends Node2D

var tile_map
var tile_w
var tile_h

var timeline = []

# Called when the node enters the scene tree for the first time.
func _ready():
	tile_map = $TileMap
	tile_w = tile_map.tile_set.tile_size.x
	tile_h = tile_map.tile_set.tile_size.y
	
	print("Tile Width: ")
	print(tile_w)
	print("Tile Height: ")
	print(tile_h)
	var player = get_node("OverworldPlayer");
	player.position.x = 24
	player.position.y = 24

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
