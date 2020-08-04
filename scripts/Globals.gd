extends Node

var viewport_width = ProjectSettings.get_setting("display/window/size/width")
var viewport_height = ProjectSettings.get_setting("display/window/size/height")
var bevel : Vector2 = Vector2(20,20)

enum PHASE {STARTING, PLAYING, CONTINUE, OVER}
enum BRICK_TYPE {
	DEFAULT, EXPAND, CONTRACT, 
	SLOW, FAST, FADE,
	LIFE, DEATH, MULTIBALL,
	FULL
}
const BRICK_TYPE_COLOR = {
	0: "White",
	1: "Light Sky Blue",
	2: "Maroon",
	3: "Olive Drab",
	4: "Orange",
	5: "Slate Blue",
	6: "Turquoise",
	7: "Gold",
	8: "Deep Pink",
	9: "Firebrick",
	10: "Light Green",
}
const HEROES = {
	"Warrior":0,
	"Magician":1,
	"Thief":2
}

signal ball_fire
signal brick_hit(brick)
signal modifier_pickup
signal life_lost
signal game_continue
signal game_won
signal game_over

const bb_notification_game_start = "[center]Press space to start[/center]"
const bb_notification_game_continue = "[center]Press space to continue[/center]"
const bb_notification_game_won = "[center]You win! Press space to restart[/center]"
const bb_notification_game_over = "[center]Game over. Press space to restart[/center]"

var levels

func _ready():
	var f := File.new()
	f.open("res://data/levels.json", File.READ)
	levels = JSON.parse(f.get_as_text()).result
	f.close()
