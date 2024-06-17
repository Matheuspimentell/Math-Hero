class_name TimeAttackTransition extends CanvasLayer

@onready var animationPlayer = $AnimationPlayer

func start_transition():
	animationPlayer.play("fade_in")

func finish_transition():
	animationPlayer.play_backwards("fade_in")