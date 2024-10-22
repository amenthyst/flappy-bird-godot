extends Node2D

class_name Ground

signal crashed

var scrolling = false
@export var speed = -150

@onready var sprite1 = $Ground1/GroundSprite1
@onready var sprite2 = $Ground2/GroundSprite2

@onready var width = sprite1.texture.get_width()
# Called when the node enters the scene tree for the first time.
func _ready():
	# sets ground2 exactly to the right of ground
	
	sprite2.global_position.x = sprite1.global_position.x + width
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !scrolling:
		return
		
	sprite1.global_position.x += speed * delta
	sprite2.global_position.x += speed * delta
	
	# creates a scrolling ground, if ground 1 passes the screen it gets set back to the start
	if sprite1.global_position.x < -width:
		sprite1.global_position.x = sprite2.global_position.x + width
	if sprite2.global_position.x < -width:
		sprite2.global_position.x = sprite1.global_position.x + width


func _on_body_entered(body):
	SignalBus.emit_signal("crashed")
	speed = 0
	(body as Bird).stop()
	
func stop_scrolling():
	speed = 0

func start_scrolling():
	scrolling = true
