extends Node

var storage = File.new()
var storage_path = "user://storage.save"
var storage_data = {"highscore": 0}

var viewport_width = ProjectSettings.get_setting("display/window/size/width")
var viewport_height = ProjectSettings.get_setting("display/window/size/height")
var bevel : Vector2 = Vector2(20,20)

enum PHASE {IDLE, PLAYING, LEVEL_FAILED, LEVEL_COMPLETED}
enum BRICK_TYPE {
	DEFAULT, 
	PAD_EXPAND, PAD_CONTRACT, 
	BALL_FAST, BALL_SLOW
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

signal ball_fire
signal brick_hit(brick)
signal modifier_pickup
signal life_lost
signal game_continue
signal level_won
signal game_over
signal game_completed

const bb_notification_game_start = "[center]Press space to start[/center]"
const bb_notification_game_continue = "[center]Life lost!\nPress space to continue[/center]"
const bb_notification_level_won = "[center]Level cleared!\nPress space to continue[/center]"
const bb_notification_game_over = "[center]Game over.\nPress space for a new game[/center]"

var levels

func _ready():
	var f := File.new()
	f.open("res://data/levels.json", File.READ)
	levels = JSON.parse(f.get_as_text()).result
	f.close()
