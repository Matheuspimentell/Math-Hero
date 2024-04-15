extends Control

@export var numpad: GridContainer

#Handle all user input for this scene
func _input(event):
	if event.is_action_pressed("number0"):
		numpad.find_child("number0").find_child("AnimationPlayer").playAnimation("click")

func _ready():
	print(numpad.get_children())

func _process(delta):
	pass