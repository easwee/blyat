extends Node

var viewport_width = ProjectSettings.get_setting("display/window/size/width")
var viewport_height = ProjectSettings.get_setting("display/window/size/height")

enum phases {STARTING, PLAYING, CONTINUE, OVER}
enum brick_types {DEFAULT, MULTIPLIER}

signal ball_fire
signal brick_hit(brick)
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
