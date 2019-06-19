extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()

func _draw():
	draw_rect(Rect2(position - $CollisionShape2D.shape.extents, $CollisionShape2D.shape.extents * 2), Color(1, 0, 0))
