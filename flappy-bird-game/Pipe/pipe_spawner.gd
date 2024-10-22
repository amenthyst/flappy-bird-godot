extends Node2D

class_name PipeSpawner

var pipe_pair_scene = preload("res://Pipe/pipe_pair.tscn")

@export var pipe_speed = -150

@onready var spawntimer = $SpawnTimer

@onready var Gamemanager = $"../GameManager"

func _ready():
	# when the timer hits 0 call spawn_pipe()
	spawntimer.timeout.connect(spawn_pipe)

func start_spawning_pipes():
	spawntimer.start()
	
func spawn_pipe():
	# initiates pipe and appends it to scene
	var pipe = pipe_pair_scene.instantiate() as PipePair
	add_child(pipe)
	
	# gets the dimensions of the screen rect
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	
	# sets position of pipe to the end of the screen 
	pipe.position.x = viewport_rect.end.x
	
	
	pipe.position.y = randf_range(-350, 250)
	
	pipe.set_speed(pipe_speed)
	

func _on_bird_hit_pipe():
	SignalBus.emit_signal("bird_hit_pipe")
	stop()
	
func stop():
	# stop timer so no new pipes are made
	spawntimer.stop()
	
	# lambda expression returns the instances of PipePair out of all of the instances in the game
	for pipe in get_children().filter( func (child): return child is PipePair):
		(pipe as PipePair).set_speed(0)

func on_point_scored():
	SignalBus.emit_signal("point_scored")
	
func _process(delta):
	var score = Gamemanager.points
	spawntimer.wait_time = 3 - (score * 0.03)
