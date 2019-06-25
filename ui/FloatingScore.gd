extends Label

onready var tween = $Tween
onready var visibleTween = $VisibleTween

func _ready():
	visible = false
	visibleTween.interpolate_property(self, "visible", false, true, 0.1,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN,
		0.4
	)
	tween.interpolate_property(self, "rect_position", rect_position, Vector2(0, -100), 1.7,
		Tween.TRANS_BACK,
		Tween.EASE_OUT,
		0.4
	)
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.7,
		Tween.TRANS_BACK,
		Tween.EASE_OUT,
		0.4
	)
	visibleTween.start()
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

func _on_Tween_tween_completed(object, key):
	queue_free()
