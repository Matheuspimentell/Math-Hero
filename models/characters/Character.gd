extends CharacterBody2D
signal hit


@export var speed = 100 # Player speed in Pixels / sec
var screen_size # Actual size of the screen

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		print("Moving right")
		velocity.x += 1
	elif Input.is_action_pressed("move_left"):
		print("Moving left")
		velocity.x -= 1
	elif  Input.is_action_pressed("jump"):
		print("Jumping")
		velocity.y += 1
	elif Input.is_action_pressed("crouch"):
		print("Crouching")
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed 

	var collision = move_and_collide(velocity * delta)
	if collision:
		print("I have collided with ", collision.get_collider().name)
