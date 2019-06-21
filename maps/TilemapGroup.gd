extends Node

onready var tilemaps = get_children()

onready var dimensions = calculate_dimensions()

# Thanks to https://godotengine.org/qa/7450/how-do-i-get-tilemaps-size-height-and-width-with-script
func calculate_dimensions():
	var group_dimensions = {}
	for tilemap in tilemaps:
		var dimensions = tilemap.dimensions
		
		if not group_dimensions.has("x") or \
			dimensions.x < group_dimensions.x:
				group_dimensions.x = dimensions.x
		
		if not group_dimensions.has("y") or \
			dimensions.y < group_dimensions.y:
				group_dimensions.y = dimensions.y
		
		if not group_dimensions.has("width") or \
			dimensions.width > group_dimensions.width:
				group_dimensions.width = dimensions.width
		
		if not group_dimensions.has("height") or \
			dimensions.height > group_dimensions.height:
				group_dimensions.height = dimensions.height
		
		var dcells = dimensions.cells
		if not group_dimensions.has("cells"):
			group_dimensions.cells = dcells
		else:
			var gcells = group_dimensions.cells
			group_dimensions.cells = {
				"x": dcells.x if dcells.x < gcells.x else gcells.x,
				"y": dcells.y if dcells.y < gcells.y else gcells.y,
				"width": dcells.width if dcells.width > gcells.width else gcells.width,
				"height": dcells.height if dcells.height > gcells.height else gcells.height,
				"count": dcells.count + gcells.count
			}
	return group_dimensions

# Determine if the position has a tile on any of the tilemaps in the group.
func pos_has_tile(pos):
	for tilemap in tilemaps:
		if tilemap.pos_has_tile(pos):
			return true
	return false

# Get top tileset atlas index of tile at pos.
func get_atlas_index_at_pos(pos):
	for tilemap in helpers.array_reverse(tilemaps):
		if tilemap.pos_has_tile(pos):
			return tilemap.get_atlas_index_at_pos(pos)
	return -1

# Get topmost tileset atlas of tile at pos.
func get_atlas_at_pos(pos):
	for tilemap in helpers.array_reverse(tilemaps):
		if tilemap.pos_has_tile(pos):
			return tilemap.get_atlas_at_pos(pos)
		else:
			print("Tilemap has no pos :( ", tilemap)
	return null

# Get a list of all atlases with a tile at pos.
func get_atlases_at_pos(pos):
	var atlases = []
	for tilemap in helpers.array_reverse(tilemaps):
		if tilemap.pos_has_tile(pos):
			if atlases.has(tilemap.get_atlas_at_pos(pos)) == false:
				atlases.push_back(tilemap.get_atlas_at_pos(pos))
	return atlases

# Return the topmost tilemap of tile at pos.
func get_tilemap_at_pos(pos):
	for tilemap in tilemaps:
		if tilemap.pos_has_tile(pos):
			return tilemap.name
	return null

# Get a list of all tilemaps with a tile at pos.
func get_tilemaps_at_pos(pos):
	var _tilemaps = []
	for tilemap in tilemaps:
		if tilemap.pos_has_tile(pos):
			_tilemaps.push_back(tilemap.name)
	return _tilemaps

# Get the topmost occupied tile at pos.
# Returns the lowest tile if no occupied tile is found.
func tile_at_pos(pos):
	var tile
	for tilemap in helpers.array_reverse(tilemaps):
		if tilemap.pos_has_tile(pos) or \
			tilemap == tilemaps[0]:
			tile = tilemap.world_to_map(pos)
			break
	return tile

# Get the pos of a tile in the tilemap grid.
func pos_at_tile(tile, tilemap = null):
	if tilemap == null:
		tilemap = tilemaps[0]
	return tilemap.map_to_world(tile)

# Get tile above the tile at specified position vector
func tile_above_pos(pos):
	var tile = tile_at_pos(pos)
	return Vector2(tile.x, tile.y - 1)

# Get tile below the tile at specified position vector
func tile_below_pos(pos):
	var tile = tile_at_pos(pos)
	return Vector2(tile.x, tile.y + 1)

# Get tile left of the tile at specified position vector.
func tile_left_pos(pos):
	var tile = tile_at_pos(pos)
	return Vector2(tile.x - 1, tile.y)

# Get tile right of the tile at specified position vector.
func tile_right_pos(pos):
	var tile = tile_at_pos(pos)
	return Vector2(tile.x + 1, tile.y)

# Get a random cell from the tilemap grid
func random_cell(config = {}):
	var _range
	if not config.has("range"):
		_range = {
			"x": {
				"lower": 0,
				"upper": dimensions.width
			},
			"y": {
				"lower": 0,
				"upper": dimensions.height
			}
		}
	else:
		_range = config.range
		
#	var x = math.rand(0, dimensions.width) + dimensions.x
#	var y = math.rand(0, dimensions.height) + dimensions.y
	var x = math.rand(_range.x.lower, _range.x.upper) + dimensions.x
	var y = math.rand(_range.y.lower, _range.y.upper) + dimensions.y
	return tile_at_pos(Vector2(x, y))

func random_cell_pos():
	return pos_at_tile(random_cell())