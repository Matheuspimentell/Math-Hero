extends Node

@export_file("*.tscn") var action_scene

func take_action() -> void:
	GameManager.change_scene(action_scene)