class_name Chests

var closed_chest_sprite: Resource
var opened_chest_sprite: Resource

func _init():
	# called once, initially
	generate_chest_resource()

# can call further for additional resource generations
func generate_chest_resource():
	var chest_num = randi_range(1, 4)
	# picks a chest numbered 1 - 4
	var closed_chest = load("res://Items/Item_Assets/Chests/chest_" + str(chest_num) + ".png")
	var opened_chest = load("res://Items/Item_Assets/Chests/chest_open_" + str(chest_num) + ".png")
	# mutates the state of the local Chests object
	closed_chest_sprite = closed_chest
	opened_chest_sprite = opened_chest
