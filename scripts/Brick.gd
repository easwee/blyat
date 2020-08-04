extends KinematicBody2D

class_name Brick

const Util = preload("res://scripts/Util.gd")

onready var score_text : RichTextLabel = get_node("/root/Core/ScoreText")
onready var gfx = get_node("Sprite")
onready var size : Vector2 = gfx.get_rect().size

var type: int = 0

func on_hit():
	State.score += 1
	score_text.set_text("Score " + str(State.score))
	State.bricks_left -= 1
	Globals.emit_signal("brick_hit", self)
	if State.bricks_left == 0:
		Globals.emit_signal("game_won")
	queue_free()

func init(x: int, y: int, brick_type: int):
	var gap = 6
	var bricks_per_row = State.current_level[0].size();
	
	type = brick_type
	size = Vector2((Globals.viewport_width - (Globals.bevel.x * 2)) / bricks_per_row  - gap , 20)
	position = Vector2(
		Globals.bevel.x + gap/2 + (size.x + gap) * x,
		Globals.bevel.y + 100 + (size.y + gap) * y
	)
	gfx.color = Util.get_modifier_gfx(type)
	
	$Sprite.set_size(size)
	$Collider.get_shape().set_extents(size/2)
	$Collider.position = size/2

	set_name("Brick" + str(x) + str(y))
	add_to_group("bricks")	
