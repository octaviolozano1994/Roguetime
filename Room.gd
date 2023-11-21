extends Node2D

var tile_map
var tile_w
var tile_h

var offset_h = 8
var offset_w = 8

var timeline = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var taken_positions = []

	tile_map = $TileMap
	tile_w = tile_map.tile_set.tile_size.x
	tile_h = tile_map.tile_set.tile_size.y
	
	print("Tile Width: ")
	print(tile_w)
	print("Tile Height: ")
	print(tile_h)
	
	var used_rect = tile_map.get_used_rect()
	var used_rect_starting_position = used_rect.position
	var used_rect_size = used_rect.size

	#Place the player on a random tile

	var player = get_node("OverworldPlayer");

	var min_x = 1#used_rect_starting_position.x
	var max_x = 16#used_rect_size - used_rect_starting_position.x
	var random_x = randi() % (max_x - min_x + 1) + min_x

	var min_y = 1#used_rect_starting_position.x
	var max_y = 9#used_rect_size - used_rect_starting_position.x
	var random_y = randi() % (max_y - min_y + 1) + min_y	

	player.position.x = random_x * tile_w + offset_w
	player.position.y = random_y * tile_h + offset_h

	player.target_position = player.position

	taken_positions.push_back(player.position)
	print(taken_positions)

	var enemy_scene = load("res://overworld_enemy.tscn")
	var enemy = enemy_scene.instantiate()
	add_child(enemy)

	random_x = randi() % (max_x - min_x + 1) + min_x
	random_y = randi() % (max_y - min_y + 1) + min_y

	enemy.position.x = random_x *  tile_w + offset_w
	enemy.position.y = random_y * tile_h + offset_h

	while enemy.position in taken_positions:
		random_x = randi() % (max_x - min_x + 1) + min_x
		random_y = randi() % (max_y - min_y + 1) + min_y

		enemy.position.x = random_x
		enemy.position.y = random_y

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
