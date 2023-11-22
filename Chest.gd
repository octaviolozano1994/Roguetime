extends Node2D

@export var closed_chest: CompressedTexture2D
@export var opened_chest: CompressedTexture2D

func _ready():
	var chest_generator = Chests.new()

	# use the chest generator to retrieve 2 random chest sprites for open and close
	var imported_closed_chest: Resource	= chest_generator.closed_chest_sprite
	var imported_opened_chest: Resource	= chest_generator.opened_chest_sprite

	# if imported successfully, then load the above sprites
	if imported_closed_chest and imported_opened_chest:
		closed_chest = imported_closed_chest
		opened_chest = imported_opened_chest
	else: # default sprite is a flamethrower sprite so it's obvious it wasn't loaded properly
		closed_chest = load(ItemManager.DEFAULT_SPRITE)
		opened_chest = closed_chest
