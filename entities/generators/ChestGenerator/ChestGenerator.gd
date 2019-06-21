extends "res://entities/generators/EntityGenerator/EntityGenerator.gd"

class_name ChestGenerator

func make_entity():
	var new_entity = Entity.instance()
	new_entity.generator = self
	
	if not randomize_spawn:
		new_entity.position = self.position
	else:
		map.random_spawn(new_entity)
	
	entity_count += 1
	
	EventBus.dispatch("add_entity", {
		"entity": new_entity,
		"instance": false,
		"container_id": target_container_id
	})

func spawn_acceptable(tilemap, pos):
	var cell = tilemap.world_to_map(pos)
	var above = tilemap.tile_above_pos(pos)
	var below = tilemap.tile_below_pos(pos)

	# Code for JungleDirt tileset
#	if tilemap.get_cell(above.x, above.y) == -1 \
#		and tilemap.get_cell(cell.x, cell.y) == -1 \
#		and tilemap.get_cell(below.x, below.y) != -1:
	# Code for SanityBrick tileset
	if tilemap.get_cell(above.x, above.y) == -1 \
		and tilemap.get_cell(cell.x, cell.y) == 0 \
		and tilemap.get_cell(below.x, below.y) >= 1:
			return true
	return false