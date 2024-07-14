extends Control

var options: Array
@onready var confirm_action = $MarginContainer/time_attack_options/menu_options/confirm_option
@onready var back_action = $MarginContainer/time_attack_options/menu_options/back_option
var selected_option = 0

func _ready():
	options = find_children("option*", "BoxContainer")
	options.append_array(find_children("*_option", "Label"))
	_set_action_highlighted(0,0)
	_set_selected_option(0)

func _input(event):
	if event.is_action_released("ui_up") and selected_option > 0 and selected_option <= options.size()-3:
		_set_selected_option(selected_option-1)
	elif event.is_action_released("ui_down") and selected_option < options.size()-3:
		_set_selected_option(selected_option+1)
	elif event.is_action_released("ui_down") and selected_option == options.size()-3:
		options[selected_option].find_child("TextureRect").set_visible(false)
		_set_action_highlighted(5,0)
		selected_option+=1
	elif selected_option > options.size()-3 and event.is_action_released("ui_up"):
		selected_option = options.size()-3
		options[selected_option].find_child("TextureRect").set_visible(true)
		_set_action_highlighted(0,0)
	elif event.is_action_released("ui_right") and selected_option == options.size()-2:
		selected_option+=1
		_set_action_highlighted(0,5)
	elif event.is_action_released("ui_left") and selected_option == options.size()-1:
		selected_option-=1
		_set_action_highlighted(5,0)
	elif event.is_action_released("ui_accept"):
		if selected_option > options.size()-3 and selected_option < options.size():
			for option in options:
				if _is_option_editable(option):
					option.save_value()
			options[selected_option].take_action()
		elif options[selected_option].is_in_group("ArrayOption"):
			options[selected_option].cycle_option()
		elif options[selected_option].is_in_group("TextOption"):
			options[selected_option].focus_text()

func _set_selected_option(option: int):
	var current_option = options[selected_option]
	var next_option = options[option]
	if current_option.is_in_group("TextOption") and current_option.text_label.has_focus():
		options[selected_option].unfocus_text()
	if _is_option_editable(current_option):
		options[selected_option].find_child("TextureRect").set_visible(false)
	if _is_option_editable(next_option):
		options[option].find_child("TextureRect").set_visible(true)
	selected_option = option

func _set_action_highlighted(confirm_outline: int, back_outline: int) -> void:
	confirm_action.set("theme_override_constants/outline_size", confirm_outline)
	back_action.set("theme_override_constants/outline_size", back_outline)

func _is_option_editable(option) -> bool:
	return option.is_in_group("ArrayOption") or option.is_in_group("TextOption")
