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

var allowed_to_open = false

export(String, 'north', 'west', 'south', 'east') var direction_name = 'north'

onready var Animator = $Sprite/AnimationPlayer
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var anim = direction_names[direction] + '_idle'
	Animator.play(anim)
	direction = direction_vectors[direction_name]
	pass

func on_Body_entered(body):
	print("entered!")
	pass

func on_Body_exited(body):
	print("gone")
	pass