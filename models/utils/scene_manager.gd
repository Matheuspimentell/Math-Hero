extends Node

const sum_screen = preload("res://levels/time_attack/time_attack_screen.tscn")
const next_level = preload("res://scenes/transitions/next_level.tscn")

func load_scene(transition_type: String):
	var transition_scene
	
	match transition_type:
		"next level":
			transition_scene = next_level.instantiate()

	get_tree().root.add_child(transition_scene)
	await transition_scene.start_transition()

	# reload previously active scene from scene tree
	get_tree().reload_current_scene() # TODO: Change so it loads the new scene instead of reloading the cuurent
	await transition_scene.finish_transition()