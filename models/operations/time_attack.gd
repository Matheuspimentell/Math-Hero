extends Control

@export var numpad: GridContainer

func _ready():
	print(numpad.get_children())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('numpad0'):
		numpad.find_child('number0').find_child('AnimationPlayer').playAnimation('click')
	if Input.is_action_just_pressed('numpad1'):
		numpad.find_child('number1').find_child('AnimationPlayer').playAnimation('click')
	if Input.is_action_just_pressed('numpad2'):
		numpad.find_child('number2').find_child('AnimationPlayer').playAnimation('click')
	if Input.is_action_just_pressed('numpad3'):
		numpad.find_child('number3').find_child('AnimationPlayer').playAnimation('click')
	if Input.is_action_just_pressed('numpad4'):
		numpad.find_child('number4').find_child('AnimationPlayer').playAnimation('click')
	if Input.is_action_just_pressed('numpad5'):
		numpad.find_child('number5').find_child('AnimationPlayer').playAnimation('click')
	if Input.is_action_just_pressed('numpad6'):
		numpad.find_child('number6').find_child('AnimationPlayer').playAnimation('click')
	if Input.is_action_just_pressed('numpad7'):
		numpad.find_child('number7').find_child('AnimationPlayer').playAnimation('click')
	if Input.is_action_just_pressed('numpad8'):
		numpad.find_child('number8').find_child('AnimationPlayer').playAnimation('click')
	if Input.is_action_just_pressed('numpad9'):
		numpad.find_child('number9').find_child('AnimationPlayer').playAnimation('click')
