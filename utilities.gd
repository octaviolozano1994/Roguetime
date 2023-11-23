extends Node2D

func rand_range(_min, _max):
	var random_value = randi() % (_max - _min + 1) + _min
	print(random_value)
	return random_value