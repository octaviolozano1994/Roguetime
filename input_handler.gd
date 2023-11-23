extends Node2D

var player
var DIR_UP = Vector2(0, -get_parent().tile_h)
var DIR_DOWN = Vector2(0, get_parent().tile_h)
var DIR_LEFT = Vector2(-get_parent().tile_w, 0)
var DIR_RIGHT = Vector2(get_parent().tile_w, 0)

#Checks for movement inputs
func CheckMovement(_target):
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
        return -1