extends StaticBody2D

const animation_frames = {
	'north': [6, 7, 8],
	'west': [22, 23, 24],
	'south': [38, 39, 40],
	'east': [54, 55, 56]
}

var direction_names = {
	Vector2(0, -1): 'north',
	Vector2(-1, 0): 'west',
	Vector2(0, 1): 'south',
	Vector2(1, 0): 'east'
}

var direction = Vector2(0, -1)
export(bool) var random_direction = false

var active = false
var opened = false

var generator

export(String, 'north', 'west', 'south', 'east') var direction_name = 'north'

onready var Animator = $Sprite/AnimationPlayer
var anim_action = '_idle'

onready var Detection = $DetectionPivot/DetectionOffset/DetectionArea
var direction_vectors = {
	'north': Vector2(0, -1),
	'west': Vector2(-1, 0),
	'south': Vector2(0, 1),
	'east': Vector2(1, 0)
}

# Called when the node enters the scene tree for the first time.
func _ready():
	Detection.connect("body_entered", self, "on_Body_entered")
	Detection.connect("body_exited", self, "on_Body_exited")
	
	direction = direction_vectors[direction_name]
	
	if random_direction:
		randomize_direction()
		direction_name = direction_names[direction]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if active and not opened and Input.is_action_just_pressed("ui_interact"):
		opened = true
		anim_action = '_open'
		Animator.play(direction_names[direction] + anim_action)
		print("hit")
		
	var anim = direction_names[direction] + anim_action
	if not opened:
		Animator.play(anim)
	direction = direction_vectors[direction_name]

func on_Body_entered(body):
	if body.name == 'Player':
		print("entered!")
		active = true
		anim_action = '_active'

func on_Body_exited(body):
	if body.name == 'Player':
		active = false
		if not opened:
			anim_action = '_idle'

func spawn_acceptable(tilemap, pos):
	var cell = tilemap.tile_at_pos(pos)
	var tilemap_name = tilemap.get_tilemap_at_pos(pos)
	var tilemap_count = tilemap.get_tilemaps_at_pos(pos).size()
	if tilemap_name == "Floors" and tilemap_count == 1:
#		print("YES!", tilemap_count, " ", tilemap.get_tilemaps_at_pos(pos))
		return true
#	else:
#		print(tilemap)
	return false

# Randomize the chest's direction.
func randomize_direction():
	var rand_x = 0
	var rand_y = 0
	while ((rand_x == 0 and rand_y == 0) or (rand_x == 1 and rand_y == 1)):
		rand_x = math.rand(0, 1)
		rand_y = math.rand(0, 1)
	
	direction = Vector2(rand_x, rand_y)
	print(direction, " ", rand_x, " ", rand_y)