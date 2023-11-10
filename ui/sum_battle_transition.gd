extends CanvasLayer


func change_scene(target_scene: String) -> void:
	await $AnimationPlayer.play("slash_in")
	get_tree().change_scene_to_file(target_scene)
	await $AnimationPlayer.play_backwards("slash_in")
	