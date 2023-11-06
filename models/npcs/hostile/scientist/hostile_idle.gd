extends State
class_name HostileIdle
signal hasReachedPlayer

@export var enemy: CharacterBody2D # Reference to the enemy that implements this state
@export var moveSpeed := 50.0 # Movement speed (Can be altered inside the engine's UI)

var moveDirection: Vector2 # Movement direction for the enemy

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
					hasReachedPlayer.emit()
