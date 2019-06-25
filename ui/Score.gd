extends HBoxContainer

onready var points_value = $MarginContainer/PointsValue

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.listen("score_updated", self, "on_Score_updated")

func on_Score_updated(data):
	var amount = data.points
	points_value.text = String(amount)