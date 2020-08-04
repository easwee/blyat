extends Node2D

const PAD = preload("res://components/Pad.tscn")
const BALL = preload("res://components/Ball.tscn")
const BRICK = preload("res://components/Brick.tscn")
const MODIFIER = preload("res://components/Modifier.tscn")

const Util = preload("res://scripts/Util.gd")

onready var notification : RichTextLabel = get_node("/root/Core/Notification")
onready var score_text : RichTextLabel = get_node("/root/Core/ScoreText")

func _ready():
	State.game_phase = Globals.PHASE.STARTING
	State.current_level = Globals.levels["0"]
	
	generate_level(State.current_level)
	spawn_pad()
	spawn_ball()
	
	Globals.connect("ball_fire", self, "on_ball_fire")
	Globals.connect("brick_hit", self, "on_brick_hit")
	Globals.connect("life_lost", self, "on_life_lost")
	Globals.connect("game_won", self, "on_game_won")
	Globals.connect("modifier_pickup", self, "on_modifier_pickup")

	notification.bbcode_text = Globals.bb_notification_game_start

func generate_level(level):
	for i in level.size():
		for j in level[i].size():
			place_brick(j, i, level[i][j])

func place_brick(x: int, y: int, type: int):
	if(type == -1):
		return
	
	var brick : Brick = BRICK.instance()
	add_child(brick)
	brick.init(x, y, type)
	State.bricks_left += 1

func spawn_ball():
	var ball : Ball = BALL.instance()
	add_child(ball)
	
func spawn_pad():
	var pad : Pad = PAD.instance()
	add_child(pad)

func spawn_modifier(position: Vector2, type: int):
	var modifier : Modifier = MODIFIER.instance()
	add_child(modifier)
	modifier.type = type
	modifier.position = position
	modifier.add_to_group("modifiers")
	modifier.gfx.color = Util.get_modifier_gfx(type)

func on_ball_fire():
	if State.game_phase == Globals.PHASE.OVER:
		reset_game()
	
	State.game_phase = Globals.PHASE.PLAYING
	notification.hide()

func on_brick_hit(brick):
	if(brick.type != Globals.BRICK_TYPE.DEFAULT):
		spawn_modifier(brick.position + (brick.size / 2), brick.type)

func on_modifier_pickup(type):
	print("pickup")

func on_life_lost():
	State.tries -= 1

	if State.tries > 0:
		State.game_phase = Globals.PHASE.CONTINUE
		notification.bbcode_text = Globals.bb_notification_game_continue
	else:
		State.game_phase = Globals.PHASE.OVER
		notification.bbcode_text = Globals.bb_notification_game_over
	notification.show()

func on_game_won():
	State.game_phase = Globals.PHASE.OVER
	notification.show()
	notification.bbcode_text = Globals.bb_notification_game_won

func reset_game():
	State.score = 0
	State.tries = 3
	State.bricks_left = 0
	State.current_level = Globals.levels["0"]
	score_text.set_text("Score " + str(State.score))
	for item in get_tree().get_nodes_in_group("bricks"):
		item.queue_free()

	generate_level(State.current_level)
