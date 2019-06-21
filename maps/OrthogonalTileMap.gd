extends TileMap

onready var dimensions = calculate_dimensions()

onready var atlases = get_tileset_atlases()

func get_tileset_atlases():
	var atlas_indexes = tile_set.get_tiles_ids()
	var atlas_names = []
	for index in atlas_indexes:
		atlas_names.push_back(tile_set.tile_get_name(index))
	return atlas_names

func _init():
	pass
	#collision_layer = 2 # 2 is the environment later, setting here because I don't want to update for every individual tilemap

# Thanks to https://godotengine.org/qa/7450/how-do-i-get-tilemaps-size-height-and-width-with-script
func calculate_dimensions():
	# Get list of all positions where there is a tile
	var used_cells = self.get_used_cells()

	# If there are none, return null result
	if used_cells.size() == 0:
		return {x=0, y=0, width=0, height=0}

	# Take first cell as reference
	var min_x = used_cells[0].x
	var min_y = used_cells[0].y
	var max_x = min_x
	var max_y = min_y

	# Find bounds
	for i in range(1, used_cells.size()):
		var pos = used_cells[i]

		if pos.x < min_x:
			min_x = pos.x
		elif pos.x > max_x:
			max_x = pos.x

		if pos.y < min_y:
			min_y = pos.y
		elif pos.y > max_y:
			max_y = pos.y

	# Return resulting bounds
	return {
		x = min_x * self.cell_size.x,
		y = min_y * self.cell_size.y,
		width = (max_x - min_x + 1) * self.cell_size.x,
		height = (max_y - min_y + 1) * self.cell_size.y,
		cells = {
	        x = min_x,
	        y = min_y,
	        width = max_x - min_x + 1,
	        height = max_y - min_y + 1,
			count = used_cells.size()
		}
    }

# Get tile above the tile at specified position vector
func tile_above_pos(pos):
	var tile = world_to_map(pos)
	return Vector2(tile.x, tile.y - 1)

# Get tile below the tile at specified position vector
func tile_below_pos(pos):
	var tile = world_to_map(pos)
	return Vector2(tile.x, tile.y + 1)

# Get tile left of the tile at specified position vector.
func tile_left_pos(pos):
	var tile = world_to_map(pos)
	return Vector2(tile.x - 1, tile.y)

# Get tile right of the tile at specified position vector.
func tile_right_pos(pos):
	var tile = world_to_map(pos)
	return Vector2(tile.x + 1, tile.y)

# Determine if world map pos has an occupied tile.
func pos_has_tile(pos):
	var tile = world_to_map(pos)
	return get_cell(tile.x, tile.y) != -1

# Get tileset atlas index of tile at pos.
func get_atlas_index_at_pos(pos):
	var tile = world_to_map(pos)
	return get_cell(tile.x, tile.y)
	
# Get tileset atlas of tile at pos.
func get_atlas_at_pos(pos):
	var tile = world_to_map(pos)
	var tileset_index = get_cell(tile.x, tile.y)
	
	if tileset_index == -1:
		return null
	
	return tile_set.tile_get_name(tileset_index)

# Get a random cell from the tilemap
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
	return world_to_map(Vector2(x, y))

func random_cell_pos():
	return map_to_world(random_cell())