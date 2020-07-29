extends KinematicBody2D

class_name Ball

const speed : int = 300
var direction : Vector2 = Vector2(0.3, -1)
var velocity : Vector2 = Vector2(0, 0)

onready var pad = get_node("/root/Arena/Pad")
onready var size : Vector2 = get_node("Sprite").get_rect().size

func _ready():
	Globals.connect("game_activated", self, "on_game_activated")

func _physics_process(delta):
	if not State.game_active:
		align_spawn_position()
		return 
	
	if position.y > Globals.viewport_height + 20:
		reset()
	
	var collision = move_and_collide(velocity * delta)

	if collision:
		var collider = collision.collider
		var diff : Vector2 = Vector2()
		
		if collider.is_in_group("bricks"):
			collider.on_hit()

		var reflect : Vector2 = collision.remainder.bounce(collision.normal)
		
		velocity = velocity.bounce(collision.normal)

		# TODO: handle bounce correctly
		if collider.name == "Pad":
			diff = position - collider.position 
			reflect.x *= diff.normalized().x
			velocity.x *= diff.normalized().x

		move_and_collide(reflect)

func on_game_activated():
	velocity = direction * speed

func reset():
	State.game_active = false
	velocity = Vector2()
	align_spawn_position()

func align_spawn_position():
	position = pad.position + Vector2(0, -10)
