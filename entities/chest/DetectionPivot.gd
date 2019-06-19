extends Position2D

onready var parent = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	update_pivot_angle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	update_pivot_angle()

func update_pivot_angle():
	rotation = parent.direction.angle()