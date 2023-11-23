extends Node2D

var target_position: Vector2
var moving = false
var speed = 100
var rewind_speed = 200
var timeline_handler = get_parent().timeline_handler
var input_handler = get_parent().input_handler

# Called when the node enters the scene tree for the first time.
func _ready():
	target_position = Vector2(24, 24)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !moving:
        #Check for movement inputs
		var movement = input_handler.CheckMovement()

        #Check if we got a movement
		if movement != -1:
            #If we got a movement check the movement
			CheckMovement(movement["direction"], movement["opposite_direction"])

			movement = -1
	else:
		move_towards_target(delta)
			

#Move towards the target position
func move_towards_target(delta):
	var direction = (target_position - position).normalized()
	position += direction * speed * delta
	if position.distance_to(target_position) < 1:
		position = target_position
		moving = false

#Check if the movement is valid
func CheckMovement(_direction, _opposite_direction):
	#Move and update the raycast for movement collision
	var raycast = get_node("RayCast2D")
	raycast.target_position = _direction
	raycast.force_raycast_update()

    #If we arent colliding with anything
	if !raycast.is_colliding():
        #Set the new target position
		target_position += _direction

        #We are now moving
		moving = true
	
		#Save the action to the timeline
		timeline_handler.AddAction(
			{
			"action type": "Movement",
			"actor": self,
			"direction": _direction,
			"opposite_direction" : _opposite_direction
			})
