extends Resource

enum ItemRarity {
	INVALID = -1,
	BASIC, 
	UNCOMMON,
	RARE,
	UNIQUE,
}

@export var id: int
@export var name: String
@export var sprite_texture: Resource
@export var rarity: ItemRarity

func _init(
 	item_id = -1, 
 	item_name = "VoidItem", 
 	item_sprite_texture = ItemManager.DEFAULT_SPRITE, 
 	item_rarity = ItemRarity.INVALID):

    id = item_id
    name = item_name
    sprite_texture = item_sprite_texture
    rarity = item_rarity
	


