extends CharacterBody2D

class_name Bird


@export var gravity = 800
@export var jump_force = 400
@export var rotation_speed = 2

@export var max_speed = 800


var started = false

var crash = false

var sine_value = 0

func _ready():
	velocity = Vector2.ZERO
func jump():
	velocity.y = -jump_force
	rotation = deg_to_rad(-30)
	
	
func _physics_process(delta):
	if !started:
		floating_effect()
	if !crash:
		# should process input if crash is false
		if Input.is_action_just_pressed("jump"):
			if !started:
				SignalBus.emit_signal("startgame")
				started = true
			jump()
	if started:
		fall(delta)
		move_and_collide(velocity * delta)
		rotate_bird()
	
func fall(delta):
	velocity.y += gravity * delta  
	
	if velocity.y > max_speed:
		#caps the max speed of bird
		velocity.y = max_speed
		
func rotate_bird():
	# rotate downwards when falling
	if velocity.y > 0 && deg_to_rad(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)
		rotation = min(rotation, deg_to_rad(30))

func stop():
	# stops the bird from recieving input, halts it, disabled gravity
	crash = true
	gravity = 0
	velocity = Vector2.ZERO
	
func hit_pipe():
	crash = true

func floating_effect():
	sine_value += 0.1
	position.y += sin(sine_value) 
