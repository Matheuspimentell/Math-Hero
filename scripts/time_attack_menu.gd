extends Control

var options: Array
var selected_option = 0

func _ready():
	options = find_children("option*", "BoxContainer")
	_set_selected_option(0)

func _input(event):
	if event.is_action_released("ui_up") and selected_option > 0:
		_set_selected_option(selected_option-1)
	if event.is_action_released("ui_down") and selected_option < options.size()-1:
		_set_selected_option(selected_option+1)
	if event.is_action_released("ui_accept"):
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
