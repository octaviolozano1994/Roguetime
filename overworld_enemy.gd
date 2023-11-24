extends Node2D

var target_position: Vector2
var moving = false
var speed = 100
var rewinding = false
var timeline_index = 0
var move_direction
var enemy_type : String

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")
	move_direction = Vector2.ZERO

func move_towards_target(delta):
	var direction = (target_position - position).normalized()
	position += direction * speed * delta
	if position.distance_to(target_position) < 1:
		position = target_position
		moving = false

		if TimelineHandler.rewinding:
			TimelineHandler.waitlist[name] = true

func _process(delta):
	if moving:
		move_towards_target(delta)
