extends KinematicBody2D

class_name Pad

export var max_speed : Vector2 = Vector2(510, 50)
export var acceleration : Vector2 = Vector2(50, 0)

onready var size : Vector2 = get_node("Sprite").get_rect().size

var velocity : Vector2 = Vector2(0,0)

func _ready():
	position = Vector2(Globals.viewport_width / 2, Globals.viewport_height - 100)
	set_name("Pad")

func _physics_process(delta):
	if Input.is_action_pressed("ui_select"):
		trigger_game_active()
	if Input.is_action_pressed("ui_right") and velocity.x < max_speed.x:
		velocity.x += acceleration.x
	if Input.is_action_pressed("ui_left") and velocity.x < max_speed.x:
		velocity.x -= acceleration.x

	velocity.x = lerp(velocity.x, 0, 0.1)

	var collision = move_and_collide(velocity * delta)

func trigger_game_active():
	if State.game_phase != Globals.PHASE.PLAYING:
		Globals.emit_signal("ball_fire")





