extends Label

onready var tween = $Tween

func _ready():
	tween.interpolate_property(self, "rect_position", rect_position, Vector2(0, -100), 0.3,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.3,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	tween.start()

func _physics_process(delta):
#	float_score()
#	update()
	pass

func set_position(pos):
	rect_position = pos

func set_value(value):
	text = String(value)
	print(text)

func float_score():
	rect_position.y -= 5
	print(rect_position)

func _draw():
#	draw_circle(Vector2(0, 0), 10, Color(1, 0, 0))
	pass