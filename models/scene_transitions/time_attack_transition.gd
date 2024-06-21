class_name TimeAttackTransition extends CanvasLayer

@onready var animationPlayer = $AnimationPlayer
@export var wait_time: float = 1.0

func start_transition():
	animationPlayer.play("fade_in")
	await animationPlayer.animation_finished
	await get_tree().create_timer(wait_time).timeout

func finish_transition():
	animationPlayer.play_backwards("fade_in")
	await animationPlayer.animation_finished
