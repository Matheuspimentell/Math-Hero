extends Control

@onready var selection_arrow = load("res://media/art/selection_arrow.png")
var buttons: Array
var selected_option = 0

func _ready():
	buttons = find_children("menu_button*", "Button")

	for button in buttons:
		if button.disabled:
			buttons.erase(button)

	_set_selected_option(0)

func _input(event):
	if event.is_action_released("ui_up") and selected_option > 0:
		_set_selected_option(selected_option-1)
	if event.is_action_released("ui_down") and selected_option < buttons.size()-1:
		_set_selected_option(selected_option+1)
	if event.is_action_released("ui_accept"):
		buttons[selected_option]._pressed()

func _set_selected_option(option: int):
	buttons[selected_option].set_button_icon(null)
	buttons[option].set_button_icon(selection_arrow)
	selected_option = option
