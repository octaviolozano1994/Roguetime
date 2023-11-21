extends Node2D

var target_position: Vector2
var moving = false
var speed = 100
var rewinding = false
var timeline_index = 0
var move_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")
	move_direction = Vector2.ZERO

	var new_timer = get_parent().rand_range(1, 3)
	print("New timer set to: ")
	print(new_timer)
	$Timer.start(new_timer)

func move_towards_target(delta):
	var direction = (target_position - position).normalized()
	position += direction * speed * delta
	if position.distance_to(target_position) < 1:
		position = target_position
		moving = false

func _process(delta):
	if moving:
		move_towards_target(delta)

	if rewinding:
		rewind_time(delta)
	else:
		handle_input()

func rewind_time(delta):
	pass

func reset_after_rewind():
	moving = false

func handle_input():
	if not moving and not rewinding:
		var raycast = get_node("RayCast2D")
		process_movement(raycast)

func process_movement(raycast):
	if move_direction != Vector2.ZERO:
		match move_direction:
			Vector2.UP:
				check_movement(raycast, Vector2(0, -get_parent().tile_h), "Down")
			Vector2.DOWN:
				check_movement(raycast, Vector2(0, get_parent().tile_h), "Up")
			Vector2.LEFT:
				check_movement(raycast, Vector2(-get_parent().tile_w, 0), "Right")
			Vector2.RIGHT:
				check_movement(raycast, Vector2(get_parent().tile_w, 0), "Left")

func check_movement(raycast, direction, opposite_direction):
	#Move the raycast to the proper direction
	raycast.target_position = direction
	raycast.force_raycast_update()

	#Check for collision before moving
	if !raycast.is_colliding():
		target_position += direction
		moving = true

		#Reset the move_direction
		move_direction = Vector2.ZERO
		get_parent().timeline.append({
			"target_position": position,
			"direction": opposite_direction
		})
		
					
func _on_timer_timeout():
	print("Timer ended")

	var direction = randi() % 4
	move_direction = Vector2.ZERO
	match direction:
		0: move_direction = Vector2.UP
		1: move_direction = Vector2.DOWN
		2: move_direction = Vector2.LEFT
		3: move_direction = Vector2.RIGHT

	# Restart the timer with a new random interval
	var new_timer = get_parent().rand_range(1, 3)
	print("New timer set to: ")
	print(new_timer)
	$Timer.start(new_timer)
