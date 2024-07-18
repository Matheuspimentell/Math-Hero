extends BoxContainer

@export var options: Array
@export_placeholder("option name...") var option_name: String
var current_option: int
@onready var value_label = $option_value
@onready var has_saved_value = GameManager.tattack_options.has(self.name)

func _ready():
	current_option = GameManager.tattack_options[self.name] if has_saved_value else 0
	_set_label_text()

func cycle_option() -> void:
	if current_option == options.size()-1:
		current_option = 0
	else:
		current_option += 1
	_set_label_text()

func _set_label_text() -> void:
	value_label.text = options[current_option]

func save_value() -> void:
	GameManager.tattack_options[option_name] = current_option