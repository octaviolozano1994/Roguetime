extends Node2D

var player
var tile_h
var tile_w

var DIR_UP
var DIR_DOWN
var DIR_LEFT
var DIR_RIGHT

func SetupReferences(_player, _tile_w, _tile_h):
	player = _player
	tile_w = _tile_w
	tile_h = _tile_h

	DIR_UP = Vector2(0, -tile_h)
	DIR_DOWN = Vector2(0, tile_h)
	DIR_LEFT = Vector2(-tile_w, 0)
	DIR_RIGHT = Vector2(tile_w, 0)

#Checks for movement inputs
func CheckMovement():
	if Input.is_action_pressed("Up"):
		return { 
			"direction" : DIR_UP,
			"opposite_direction" : DIR_DOWN
		}
	elif Input.is_action_pressed("Down"):
		return {
			"direction" : DIR_DOWN,
			"opposite_direction" : DIR_UP
		}
	elif Input.is_action_pressed("Left"):
		return {
			"direction" : DIR_LEFT,
			"opposite_direction" : DIR_RIGHT
		}
	elif Input.is_action_pressed("Right"):
		return {
			"direction" : DIR_RIGHT,
			"opposite_direction" : DIR_LEFT
		}
	else:
		return null
