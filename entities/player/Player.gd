extends KinematicBody2D

const BASE_SPEED = 100
const ACCELERATION = 50
const MAX_SPEED = 200

var friction = false
var motion = Vector2(0, 0)
var direction = Vector2(1, 0)

onready var Animator = $Sprite/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$MovementHandler.set_defaults({
		"down": funcref(self, "move_down"),
		"idle": funcref(self, "move_idle"),
		"left": funcref(self, "move_left"),
		"right": funcref(self, "move_right"),
		"up": funcref(self, "move_up")
	})

func _physics_process(delta):
	friction = true
	# Movement Right/Left
	if Input.is_action_pressed('ui_right'):
		$MovementHandler.move('right')
	elif Input.is_action_pressed('ui_left'):
		$MovementHandler.move('left')
	
	# Movement Up/Down
	if Input.is_action_pressed('ui_up'):
		$MovementHandler.move('up')
	elif Input.is_action_pressed('ui_down'):
		$MovementHandler.move('down')
	
	if friction:
		motion.x = lerp(motion.x, 0, 0.2)
		motion.y = lerp(motion.y, 0, 0.2)
	
	if motion == Vector2(0, 0):
		idle()
	
	motion = move_and_slide(motion)

###
# Movement
###

func move_down():
	motion.y = min(motion.y + ACCELERATION, MAX_SPEED)
	direction = Vector2(0, 1)
	if not Animator.is_playing():
		Animator.play('walk_down')

func move_left():
	motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	direction = Vector2(-1, 0)
	if not Animator.is_playing():
		Animator.play('walk_left')

func move_right():
	motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	direction = Vector2(1, 0)
	if not Animator.is_playing():
		Animator.play('walk_right')

func move_up():
	motion.y = max(motion.y - ACCELERATION, -MAX_SPEED)
	direction = Vector2(0, -1)
	if not Animator.is_playing():
		Animator.play('walk_up')

func idle():
	match direction:
		Vector2(1, 0):
			Animator.play("idle_right")
		Vector2(-1, 0):
			Animator.play("idle_left")
		Vector2(0, 1):
			Animator.play("idle_down")
		Vector2(0, -1):
			Animator.play("idle_up")
		_: # Shouldn't happen, but here just in case.
			direction = Vector2(1, 0)
			Animator.play("idle_right")