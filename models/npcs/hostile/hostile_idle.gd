extends State
class_name HostileIdle

@export var enemy: CharacterBody2D # Reference to the enemy that implements this state
@export var moveSpeed := 50.0 # Movement speed (Can be altered inside the engine's UI)
@export var detectionArea: Area2D

var moveDirection: Vector2 # Movement direction for the enemy

# If a player has beed detected, transition to the follow state
func _on_detection_area_body_entered(body):
	if body.name.to_lower() == "player":
		Transition.emit(self, "follow")

# When ready, move the enemy towards the positive Y axis (down)
func Enter():
	moveDirection = Vector2i(0,1)

# Make the enemt move until it hits a wall, then, make him change direction
func Physics_Update(delta: float):
	if enemy:
		enemy.velocity = moveDirection * moveSpeed
		var collision = enemy.move_and_collide(enemy.velocity * delta)

		if collision: 
			match collision.get_collider().name:
				# If the npc has collided with the map, move in the other direction
				'map':
					moveDirection *= -1
				'player':
					print("Hey, want to battle ?")
