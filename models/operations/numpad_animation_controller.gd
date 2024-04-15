extends AnimationPlayer

func playAnimation(anim_name):
	play(anim_name)

func _on_animation_finished():
	play('RESET')
