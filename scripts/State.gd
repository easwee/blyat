extends Node

var game_phase : int = Globals.PHASE.STARTING
var current_level : Array = []
var current_level_index : int = 0
var modifiers : Array = []
var tries : int = 3
var score : int = 0
var bricks_left : int = 0
