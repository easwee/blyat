extends Area2D

class_name Modifier

var fall_speed : int = 1
var velocity : Vector2

onready var gfx = get_node("Sprite")
onready var size = gfx.get_rect().size

var type : int = 0

func _ready():
	position = position - size / 2

func _physics_process(delta):
	velocity.y += fall_speed
	position += velocity * delta

func on_body_entered(body):
	if(body.name == "Pad"):
		Globals.emit_signal("modifier_pickup", type)
		queue_free()
