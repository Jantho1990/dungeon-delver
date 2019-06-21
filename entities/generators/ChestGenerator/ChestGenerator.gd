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