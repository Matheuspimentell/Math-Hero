extends CharacterBody2D

@export var speed = 300.0
var _hasBeenDetected = false

func _physics_process(delta):

	if not _hasBeenDetected:
		# Get the input direction and handle the movement/deceleration.
		var directionX = Input.get_axis("move_left", "move_right")
		var directionY = Input.get_axis("move_up", "move_down")

		if directionX:
			velocity.x = directionX * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

		if directionY:
			velocity.y = directionY * speed
		else:
			velocity.y = move_toward(velocity.y, 0, speed)

		# This returns the KinematicCollision2D object that collided with the player, if none, returns null
		var collision = move_and_collide(velocity * delta)

		if collision:
			print("Player collided with: ", collision.get_collider().name)

# If an enemy has found the player, set _hasBeenDetetcted to true
func _on_enemy_has_found_player():
	_hasBeenDetected = true
