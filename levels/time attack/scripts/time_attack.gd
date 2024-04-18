extends Control

@export var numpad: GridContainer

#Handle all user input for this scene
func _input(event):
	if event.is_action_pressed("number0"):
		numpad.find_child("number0").find_child("AnimationPlayer").playAnimation("click")
	elif event.is_action_pressed("number1"):
		numpad.find_child("number1").find_child("AnimationPlayer").playAnimation("click")
	elif event.is_action_pressed("number2"):
		numpad.find_child("number2").find_child("AnimationPlayer").playAnimation("click")
	elif event.is_action_pressed("number3"):
		numpad.find_child("number3").find_child("AnimationPlayer").playAnimation("click")
	elif event.is_action_pressed("number4"):
		numpad.find_child("number4").find_child("AnimationPlayer").playAnimation("click")
	elif event.is_action_pressed("number5"):
		numpad.find_child("number5").find_child("AnimationPlayer").playAnimation("click")
	elif event.is_action_pressed("number5"):
		numpad.find_child("number5").find_child("AnimationPlayer").playAnimation("click")
	elif event.is_action_pressed("number6"):
		numpad.find_child("number6").find_child("AnimationPlayer").playAnimation("click")
	elif event.is_action_pressed("number7"):
		numpad.find_child("number7").find_child("AnimationPlayer").playAnimation("click")
	elif event.is_action_pressed("number8"):
		numpad.find_child("number8").find_child("AnimationPlayer").playAnimation("click")
	elif event.is_action_pressed("number9"):
		numpad.find_child("number9").find_child("AnimationPlayer").playAnimation("click")

func _process(_delta):
	pass