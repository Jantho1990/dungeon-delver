extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var tilemaps = $TilemapGroup.get_children()
	var tileset1 = tilemaps[0].tile_set
	var ts0 = tileset1.tile_get_name(3)
	var tids = tileset1.get_tiles_ids()
	var atlas = tileset1.find_tile_by_name(ts0)
	
	var tileset_atlas_name = tilemaps[1].get_atlas_at_pos(Vector2(0, 0))
	
	var atlases = tilemaps[0].atlases
	
	var shapes = tileset1.tile_get_shapes(0)
	
	# Test inverted arrays
	var arr1 = [0, 1, 3, 6]
	var arr2 = arr1.duplicate()
	arr2.invert()
	
	# Time to test my TilemapGroup stuff.
	var tmg = $TilemapGroup
	var test0 = tmg.get_atlas_at_pos(Vector2(0, -33))
	var test1 = tmg.pos_has_tile(Vector2(0, 0))
	var test2 = tmg.pos_has_tile(Vector2(-150, -100))
	
	breakpoint
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
