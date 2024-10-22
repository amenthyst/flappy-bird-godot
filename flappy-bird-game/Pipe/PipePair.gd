extends Node2D

class_name PipePair

signal bird_hit_pipe
signal point_scored

var speed = 0

func set_speed(newspeed):
	speed = newspeed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta
	

func _on_bird_hit_pipe(body):
	SignalBus.emit_signal("bird_hit_pipe")

func _on_point_scored(body):
	SignalBus.emit_signal("point_scored")
