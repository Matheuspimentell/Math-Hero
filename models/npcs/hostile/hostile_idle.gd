extends State
class_name HostileIdle

@export var enemy: CharacterBody2D
@export var moveSpeed := 50.0

var moveDirection = Vector2(0,0)

func _ready():
	print("Hey!, I'm a hostile npc :(")

func Enter():
	moveDirection = Vector2i(0,1)

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
