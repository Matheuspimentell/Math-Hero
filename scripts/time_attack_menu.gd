extends Control

var options: Array
@onready var start_action = $MarginContainer/time_attack_options/menu_options/start_option
@onready var back_action = $MarginContainer/time_attack_options/menu_options/back_option
var selected_option = 0

func _ready():
	options = find_children("option*", "BoxContainer")
	options.append_array(find_children("*_option", "Label"))

	_set_selected_option(0)

func _input(event):
	if event.is_action_released("ui_up") and selected_option > 0 and selected_option <= options.size()-3:
		_set_selected_option(selected_option-1)
	elif event.is_action_released("ui_down") and selected_option < options.size()-3:
		_set_selected_option(selected_option+1)
	elif event.is_action_released("ui_down") and selected_option == options.size()-3:
		options[selected_option].find_child("TextureRect").set_visible(false)
		start_action.set("theme_override_constants/outline_size", 5)
		selected_option+=1
	elif selected_option > options.size()-3 and event.is_action_released("ui_up"):
		selected_option = options.size()-3
		options[selected_option].find_child("TextureRect").set_visible(true)
		start_action.set("theme_override_constants/outline_size", 0)
		back_action.set("theme_override_constants/outline_size", 0)
	elif event.is_action_released("ui_right") and selected_option == options.size()-2:
		selected_option+=1
		start_action.set("theme_override_constants/outline_size", 0)
		back_action.set("theme_override_constants/outline_size", 5)
	elif event.is_action_released("ui_left") and selected_option == options.size()-1:
		selected_option-=1
		start_action.set("theme_override_constants/outline_size", 5)
		back_action.set("theme_override_constants/outline_size", 0)
	elif event.is_action_released("ui_accept"):
		if options[selected_option].is_in_group("ArrayOption"):
			options[selected_option].cycle_option()
		elif options[selected_option].is_in_group("TextOption"):
			options[selected_option].focus_text()	

func _set_selected_option(option: int):
	if options[selected_option].is_in_group("TextOption") and options[selected_option].text_label.has_focus():
		options[selected_option].unfocus_text()
	options[selected_option].find_child("TextureRect").set_visible(false)
	options[option].find_child("TextureRect").set_visible(true)
	selected_option = option