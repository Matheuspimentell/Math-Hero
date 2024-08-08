extends Control

const main_menu = "res://scenes/main_menu.tscn"

@onready var leaderboard: Label = $MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/leaderboard_label

func _input(event):
	if event.is_action_released("accept"):
		SfxManager.stop("upbeat_background")
		GameManager.change_scene(main_menu)

func _ready():
	pass # Replace with function body.

# Leaderboard model
# "1. fulano de tal - 000:00.000
#
# 2. fulano de tal - 000:00.000
#
# 3. fulano de tal - 000:00.000
#
# 4. fulano de tal - 000:00.000
#
# 5. fulano de tal - 000:00.000"
