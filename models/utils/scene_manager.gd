extends Node

const sum_screen = preload("res://levels/time_attack/sum_screen.tscn")
const time_attack_transition_scene = preload("res://scenes/transitions/time_attack_transition.tscn")

func load_scene(transition_type: String):
	var transition_scene
	
	match transition_type:
		"time_attack":
			transition_scene = time_attack_transition_scene.instantiate()

	get_tree().root.add_child(transition_scene)
	await transition_scene.start_transition()

	# reload previously active scene from scene tree
	get_tree().reload_current_scene()
	transition_scene.finish_transition()
	await transition_scene.animationPlayer.animation_finished
