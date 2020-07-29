extends Node2D

const PAD = preload("res://components/Pad.tscn")
const BALL = preload("res://components/Ball.tscn")
const BRICK = preload("res://components/Brick.tscn")

var bricks_start_position = Vector2(100,100)

func _ready():
	var pad : Pad = PAD.instance()
	add_child(pad)

	var ball : Ball = BALL.instance()
	add_child(ball)
	
	for i in range(10):
		for j in range(5):
			var brick : Brick = BRICK.instance()
			add_child(brick)
			brick.set_name("Brick" + str(i) + str(j))
			brick.add_to_group("bricks")
			brick.position = Vector2(
				bricks_start_position.x + (brick.size.x + 2) * i,
				bricks_start_position.x + (brick.size.y + 2) * j
			) 
