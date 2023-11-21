extends Resource

@export var flask_sprite: Resource

func _init():
    var flask_num_1 = randi_range(1, 4)
    var flask_num_2 = randi_range(1, 4)

    # randomizes a flask sprite on load
    var loaded_flask = load("res://Items/Item_Assets/Flasks/flasks_" + flask_num_1 + "_" + flask_num_2 + ".png")

    flask_sprite = loaded_flask 