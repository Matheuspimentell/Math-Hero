extends Node

enum Game_modes {Story=1, TimeAttack=2, Menu=0}

var game_mode: int = Game_modes.Menu

@onready var scene_tree = get_tree()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func change_scene(target_scene):
	if not target_scene:
		print_debug("Target scene is null!")
		scene_tree.quit() # Quit game options was pressed
	else:
		print(target_scene)
		scene_tree.change_scene_to_file(target_scene)
