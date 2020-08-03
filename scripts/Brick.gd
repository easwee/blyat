extends KinematicBody2D

class_name Brick

onready var score_text : RichTextLabel = get_node("/root/Core/ScoreText")
onready var gfx = get_node("Sprite")
onready var size = gfx.get_rect().size

var type: int = 0

func on_hit():
	State.score += 1
	score_text.set_text("Score " + str(State.score))
	State.bricks_left -= 1
	Globals.emit_signal("brick_hit", self)
	if State.bricks_left == 0:
		Globals.emit_signal("game_won")
	queue_free()
