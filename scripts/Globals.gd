extends Node

var viewport_width = ProjectSettings.get_setting("display/window/size/width")
var viewport_height = ProjectSettings.get_setting("display/window/size/height")

enum phases {STARTING, PLAYING, CONTINUE, OVER}

signal ball_fire
signal life_lost
signal game_continue
signal game_won
signal game_over

const bb_notification_game_start = "[center]Press space to start[/center]"
const bb_notification_game_continue = "[center]Press space to continue[/center]"
const bb_notification_game_won = "[center]You win! Press space to restart[/center]"
const bb_notification_game_over = "[center]Game over. Press space to restart[/center]"
