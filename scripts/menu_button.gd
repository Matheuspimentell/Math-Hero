extends Button

@export_placeholder("res://path/to/scene...") var action_scene: String

func _pressed():
	GameManager.change_scene(action_scene)