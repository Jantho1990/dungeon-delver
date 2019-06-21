extends "res://containers/EntityContainer/EntityContainer.gd"

class_name ChestContainer

func _init().():
	container_type = "Chest"
	container_callback = "on_Add_chest"
	container_callback_remove = "on_Remove_chest"

func on_Add_chest(data):
	if data.container_id == container_id:
		var entity = data.entity
		if data.instance == true:
			entity = entity.instance()
	
		add_child(entity)

func on_Remove_chest(data):
	on_Remove_entity(data)