extends Node2D

const PAD = preload("res://components/Pad.tscn")
const BALL = preload("res://components/Ball.tscn")
const BRICK = preload("res://components/Brick.tscn")

var bricks_start_position : Vector2 = Vector2(100,100)
onready var notification : RichTextLabel = get_node("/root/Arena/Notification")
onready var score_text : RichTextLabel = get_node("/root/Arena/ScoreText")

func _ready():
	State.game_phase = Globals.phases.STARTING

	var pad : Pad = PAD.instance()
	add_child(pad)

	var ball : Ball = BALL.instance()
	add_child(ball)
	
	generate_bricks()
	
	Globals.connect("ball_fire", self, "on_ball_fire")
	Globals.connect("life_lost", self, "on_life_lost")
	Globals.connect("game_won", self, "on_game_won")
	
	notification.bbcode_text = Globals.bb_notification_game_start

func generate_bricks():
	for i in range(10):
		for j in range(5):
			var brick : Brick = BRICK.instance()
			add_child(brick)
			State.bricks_left += 1
			brick.set_name("Brick" + str(i) + str(j))
			brick.add_to_group("bricks")
			brick.position = Vector2(
				bricks_start_position.x + (brick.size.x + 2) * i,
				bricks_start_position.x + (brick.size.y + 2) * j
			) 

func on_ball_fire():
	print("ball fire", State.game_phase)
	if State.game_phase == Globals.phases.OVER:
		print("reseting")
		reset_game()
	
	State.game_phase = Globals.phases.PLAYING
	notification.hide()

func on_life_lost():
	State.tries -= 1

	if State.tries > 0:
		State.game_phase = Globals.phases.CONTINUE
		notification.bbcode_text = Globals.bb_notification_game_continue
	else:
		State.game_phase = Globals.phases.OVER
		notification.bbcode_text = Globals.bb_notification_game_over
	notification.show()

func on_game_won():
	State.game_phase = Globals.phases.OVER
	notification.show()
	notification.bbcode_text = Globals.bb_notification_game_won

func reset_game():
	State.score = 0
	State.tries = 3
	State.bricks_left = 0
	
	score_text.set_text("Score " + str(State.score))
	
	for item in get_tree().get_nodes_in_group("bricks"):
		item.queue_free()

	generate_bricks()
