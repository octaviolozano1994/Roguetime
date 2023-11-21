extends Node2D

var target_position: Vector2
var moving = false
var speed = 100
var rewinding = false
var timeline_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")

func move_towards_target(delta):
	var direction = (target_position - position).normalized()
	position += direction * speed * delta
	if position.distance_to(target_position) < 1:
		position = target_position
		moving = false

func _process(delta):
	if !moving:
		for i in range(4):
			match i:
				#Up
				0:

					pass
				#Down
				1:
					pass
				#Left
				2:
					pass
				#Right
				3:
					pass