extends CharacterBody2D

@export var speed = 300.0
var moveDirection = 1

func _physics_process(delta):

	# Continuously move only in the y axis
	velocity.y = moveDirection * speed
	# Check for collisions
	var collision = move_and_collide(velocity * delta)

	# If the npc has collided with something
	if collision:
		print(self.name , " collided with: ", collision.get_collider().name)
		
		match collision.get_collider().name:
			# If the npc has collided with the map, move in the other direction
			'map':
				moveDirection *= -1
			'player':
				print("Hey, want to battle ?")

	move_and_slide()
