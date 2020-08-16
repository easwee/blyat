extends KinematicBody2D

class_name Ball

const MAX_SPEED = 1000
const MIN_SPEED = 200
const INITIAL_SPEED = 300
const SPEED_MODIFIER = 300
const deviation_multiplier = 3

var speed : int = INITIAL_SPEED
var direction : Vector2 = Vector2(0.3, -1)
var velocity : Vector2 = Vector2(0, 0)



onready var pad = get_node("/root/Core/Pad")
onready var size : Vector2 = get_node("Sprite").get_rect().size

func _ready():
	Globals.connect("ball_fire", self, "on_ball_fire")

func _physics_process(delta):
	if State.game_phase != Globals.PHASE.PLAYING:
		align_spawn_position()
		return 
	
	if position.y > Globals.viewport_height + 20:
		Globals.emit_signal("life_lost")
		reset()
	
	var collision = move_and_collide(velocity * delta)

	if collision:
		var collider = collision.collider
		var deviation : Vector2 = Vector2()
		
		if collider.is_in_group("bricks"):
			collider.on_hit()
		
		velocity = velocity.bounce(collision.normal)
		
		if collider.name == "Pad":
			deviation = position - collider.position
			velocity.x += deviation.x * deviation_multiplier
			print(velocity.x)

		var reflect : Vector2 = collision.remainder.bounce(collision.normal)
		move_and_collide(reflect)

func on_ball_fire():
	velocity = direction * speed
	speed = INITIAL_SPEED

func reset():
	velocity = Vector2()
	align_spawn_position()

func align_spawn_position():
	position = pad.position + Vector2(0, -12)
	
func modify(type):
	match(type):
		3:
			# ball speed increase
			if speed + SPEED_MODIFIER < MAX_SPEED:
				speed += SPEED_MODIFIER
				velocity = direction * speed
		4: 
			#ball speed decrease
			if speed - SPEED_MODIFIER > MIN_SPEED:
				speed -= SPEED_MODIFIER
				velocity = direction * speed

