extends Node2D

var tile_map
var tile_w
var tile_h

var offset_h = 8
var offset_w = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	var taken_positions = []

	tile_map = $TileMap
	tile_w = tile_map.tile_set.tile_size.x
	tile_h = tile_map.tile_set.tile_size.y
	
	print(TimelineHandler.timeline)
	
	var used_rect = tile_map.get_used_rect()
	var used_rect_starting_position = used_rect.position
	var used_rect_size = used_rect.size

	#Place the player on a random tile

	var player = get_node("OverworldPlayer")

	InputHandler.SetupReferences(player, tile_w, tile_h)

	var min_x = 1#used_rect_starting_position.x
	var max_x = 16#used_rect_size - used_rect_starting_position.x
	var random_x = Utilities.rand_range(min_x, max_x)

	var min_y = 1#used_rect_starting_position.x
	var max_y = 9#used_rect_size - used_rect_starting_position.x
	var random_y = Utilities.rand_range(min_y, max_y)	

	player.position.x = random_x * tile_w + offset_w
	player.position.y = random_y * tile_h + offset_h

	player.target_position = player.position

	taken_positions.push_back(player.position)
	print(taken_positions)

	#Spawn in enemies
	random_x = Utilities.rand_range(min_x, max_x)
	random_y = Utilities.rand_range(min_y, max_y)
	var ex = random_x *  tile_w + offset_w
	var ey = random_y * tile_h + offset_h

	var enemy = EnemyHandler.SpawnEnemy(self, "FlamingSkull", Vector2(ex, ey))

	while enemy.position in taken_positions:
		random_x = Utilities.rand_range(min_x, max_x)
		random_y = Utilities.rand_range(min_y, max_y)

		enemy.position.x = random_x
		enemy.position.y = random_y

	enemy.target_position = enemy.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
