extends Control

@export var numpad: GridContainer

func _ready():
	print(numpad.get_children())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('numpad0'):
		numpad.find_child('number0').find_child('AnimationPlayer').playAnimation('click')
