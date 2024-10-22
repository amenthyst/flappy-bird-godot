extends Node


@onready var bird = $"../Bird" as Bird
@onready var ground = $"../Ground" as Ground
@onready var pipe_spawner = $"../PipeSpawner" as PipeSpawner
@onready var fade = $"../Fade" as Fade
@onready var ui = $"../UI" as UI

var points = 0

func _ready():
	SignalBus.connect("startgame", on_start_game)
	SignalBus.connect("crashed", on_crash)
	SignalBus.connect("bird_hit_pipe", on_bird_hit_pipe)
	SignalBus.connect("point_scored", on_point_scored)

func on_start_game():
	ground.start_scrolling()
	pipe_spawner.start_spawning_pipes()
	
func on_crash():
	if fade != null:
		fade.play()
	ground.stop_scrolling()
	pipe_spawner.stop()
	bird.stop()
	ui.on_game_over()
	
func on_bird_hit_pipe():
	if fade != null:
		fade.play()
	ground.stop_scrolling()
	pipe_spawner.stop()
	bird.hit_pipe()
	ui.on_game_over()

func on_point_scored():
	points += 1
	ui.update_score(points)
	

