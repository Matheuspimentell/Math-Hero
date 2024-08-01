extends Button

@export_file("*.tscn") var action_scene

func _pressed():
	GameManager.change_scene(action_scene)