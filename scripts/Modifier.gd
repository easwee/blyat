extends Area2D

class_name Modifier

var fall_speed : int = 1
var velocity : Vector2

onready var gfx = get_node("Sprite")
onready var size = gfx.get_rect().size

var type : int = 0

func _ready():
	position = position - size / 2
	gfx.color = Color(type * 0.1, 0, 0, 1)

func _physics_process(delta):
	velocity.y += fall_speed
	position += velocity * delta
