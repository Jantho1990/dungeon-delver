extends Node

onready var tilemaps = get_children()

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