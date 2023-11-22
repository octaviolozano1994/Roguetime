extends Node2D

var tile_map
var tile_w
var tile_h

var offset_h = 8
var offset_w = 8

var timeline = []

func rand_range(_min, _max):
	var random_value = randi() % (_max - _min + 1) + _min
	print(random_value)
	return random_value

func load_interactables():
	load("res://InteractableChest.tscn")

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

	var min_x = 1	#used_rect_starting_position.x
	var max_x = 16 	#used_rect_size - used_rect_starting_position.x
	var min_y = 1	#used_rect_starting_position.x
	var max_y = 9	#used_rect_size - used_rect_starting_position.x

	var chest = get_node("InteractableChest")

	var random_x_chest = rand_range(min_x, max_x) 
	var random_y_chest = rand_range(min_y, max_y)

	chest.position.x = random_x_chest * tile_w + offset_w
	chest.position.y = random_y_chest * tile_h + offset_h

	#Place the player on a random tile
	var player = get_node("OverworldPlayer");

	var random_x_player = rand_range(min_x, max_x)
	var random_y_player = rand_range(min_y, max_y)	
	
	player.position.x = random_x_player * tile_w + offset_w
	player.position.y = random_y_player * tile_h + offset_h

	player.target_position = player.position

	taken_positions.push_back(player.position)
	print(taken_positions)

	var enemy_scene = load("res://overworld_enemy.tscn")
	var enemy = enemy_scene.instantiate()
	add_child(enemy)

	var random_x_enemy = rand_range(min_x, max_x)
	var random_y_enemy = rand_range(min_y, max_y)

	enemy.position.x = random_x_enemy *  tile_w + offset_w
	enemy.position.y = random_y_enemy * tile_h + offset_h

	while enemy.position in taken_positions:
		random_x_enemy = rand_range(min_x, max_x)
		random_y_enemy = rand_range(min_y, max_y)

		enemy.position.x = random_x_enemy
		enemy.position.y = random_y_enemy

	enemy.target_position = enemy.position

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
