extends Node2D

var target_position: Vector2
var moving = false
var speed = 100
var rewinding = false
var timeline_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	target_position = Vector2(24, 24)
	get_parent().timeline = []
	$AnimatedSprite2D.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving:
		move_towards_target(delta)

	if rewinding:
		rewind_time(delta)
	else:
		handle_input()

func move_towards_target(delta):
	var direction = (target_position - position).normalized()
	position += direction * speed * delta
	if position.distance_to(target_position) < 1:
		position = target_position
		moving = false

func rewind_time(delta):
	if timeline_index >= 0:
		var action = get_parent().timeline[timeline_index]
		target_position = action["target_position"]
		move_towards_target(delta)
		if position == target_position:
			timeline_index -= 1
			if timeline_index < 0:
				rewinding = false
				clear_timeline()
				reset_after_rewind()
	else:
		rewinding = false

func clear_timeline():
	get_parent().timeline.clear()

func reset_after_rewind():
	moving = false

func handle_input():
	if not moving and not rewinding:
		var raycast = get_node("RayCast2D")
		if Input.is_action_pressed("Rewind"):
			start_rewind()
		else:
			process_movement(raycast)

func start_rewind():
	if get_parent().timeline.size() > 0:
		timeline_index = get_parent().timeline.size() - 1
		rewinding = true

func process_movement(raycast):
	if Input.is_action_pressed("Up"):
		check_movement(raycast, Vector2(0, -get_parent().tile_h), "Down")
	elif Input.is_action_pressed("Down"):
		check_movement(raycast, Vector2(0, get_parent().tile_h), "Up")
	elif Input.is_action_pressed("Left"):
		check_movement(raycast, Vector2(-get_parent().tile_w, 0), "Right")
	elif Input.is_action_pressed("Right"):
		check_movement(raycast, Vector2(get_parent().tile_w, 0), "Left")

func check_movement(raycast, direction, opposite_direction):
	raycast.target_position = direction
	raycast.force_raycast_update()
	if !raycast.is_colliding():
		target_position += direction
		moving = true
		get_parent().timeline.append({
			"target_position": position,
			"direction": opposite_direction
		})
