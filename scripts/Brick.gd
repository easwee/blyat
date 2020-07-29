extends KinematicBody2D

class_name Brick

onready var score_text : RichTextLabel = get_node("/root/Arena/ScoreText")
onready var size = get_node("Sprite").get_rect().size

func on_hit():
	State.score += 1
	score_text.set_text("Score " + str(State.score))
	State.bricks_left -= 1
	if State.bricks_left == 0:
		Globals.emit_signal("game_won")
	queue_free()
