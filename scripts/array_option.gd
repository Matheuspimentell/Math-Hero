extends BoxContainer

@export var options: Array
var _current_option: int
@onready var value_label = $option_value
@onready var has_saved_value = GameManager.tattack_options.has(self.name)

func _ready():
	_current_option = GameManager.tattack_options[self.name] if has_saved_value else 0
	_set_label_text()

func cycle_option() -> void:
	if _current_option == options.size()-1:
		_current_option = 0
	else:
		_current_option += 1
	_set_label_text()

func _set_label_text() -> void:
	value_label.text = options[_current_option]

func save_value() -> void:
	GameManager.tattack_options[self.name] = _current_option