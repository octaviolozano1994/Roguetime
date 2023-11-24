extends Node2D

var enemies = []

#Spawns in an enemy at a location with a type tied to a parent
func SpawnEnemy(_parent,_type, _pos):
	var enemy_scene = load("res://overworld_enemy.tscn")
	var enemy = enemy_scene.instantiate()
	enemy.enemy_type = _type
	enemy.position = _pos
	_parent.add_child(enemy)

	enemies.append(enemy)
	return enemy

func MoveEnemies():
	for enemy in enemies:
		var options = true

		#Polulate as list with all directions
		var all_directions = [
			InputHandler.DIR_LEFT,
			InputHandler.DIR_RIGHT,
			InputHandler.DIR_UP,
			InputHandler.DIR_DOWN
		]

		#Every day Im shuffle
		all_directions.shuffle()

		#Pick a random direction until we pick one that doesnt collide
		var direction = all_directions.pop_front()

		var raycast = enemy.get_node("RayCast2D")
		raycast.target_position = direction
		raycast.force_raycast_update()

		#This COULD be infinite FIX THAT SHIT
		while raycast.is_colliding():
			if all_directions.size() == 0:
				options = false
				break

			direction = all_directions.pop_front()
		
		if options:
			#Set enemy to be moving
			enemy.target_position += direction
			enemy.moving = true

			#You can negate Vectors woohoo!
			TimelineHandler.AddAction(
				{
					"action type": "Movement",
					"actor": enemy,
					"direction": direction,
					"opposite_direction" : -direction
				})
				
		var i = 0
		for frame in TimelineHandler.timeline:
			#print("Frame #")
			#print(i)

			var j = 0
			for action in frame:
				#print("Action #")
				#print(j)
				#print(action)
				j += 1
			
			i += 1
