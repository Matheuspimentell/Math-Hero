extends State
class_name HostileFollow
signal hasReachedPlayer

@export var enemy: CharacterBody2D # Reference to the enemy that has this state
@export var moveSpeed := 50.0 # Enemy move speed (can be altered inside the engine UI)

var player: CharacterBody2D # Reference to the player

# When entering this state, get a reference to the player
func Enter():
	player = get_tree().get_first_node_in_group("Player")

# Calculate the distance between player and enemy and make enemy move towards player
func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position

	# If the distance is greater than 30, make the enemy move towards the player with moveSpeed speed
	if direction.length() > 30.0:
		enemy.velocity = direction.normalized() * moveSpeed
		enemy.move_and_collide(enemy.velocity * delta)
	# Else (Has reached player within 30 of distance)
	else:
		hasReachedPlayer.emit()
		enemy.velocity = Vector2(0,0)
	
	# If the distance is greater than 100, transition to the idle state
	if direction.length() > 100.0:
		Transition.emit(self, "idle")
