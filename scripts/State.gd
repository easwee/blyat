extends Node

var game_phase : int = Globals.PHASE.IDLE
var can_fire : bool = true
var current_level : Array = []
var current_level_index : int = 0
var modifiers : Array = []
var tries : int = 1
var score : int = 0
var best : int = 0
var bricks_left : int = 0
