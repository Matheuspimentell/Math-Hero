extends BoxContainer

@export_placeholder("option name...") var option_name: String
@onready var text_label = $option_value
@onready var has_saved_value = GameManager.tattack_options.has(self.name)

var ascii = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

func _ready():
	text_label.text = GameManager.tattack_options[self.name] if has_saved_value else ''

func focus_text() -> void:
	text_label.grab_focus()

func unfocus_text() -> void:
	text_label.release_focus()

func save_value() -> void:
	var input_seed = text_label.text
	if input_seed.length() <= 0:
		input_seed = _gen_unique_hash(10)
	GameManager.tattack_options[option_name] = input_seed

func _gen_unique_hash(length: int):
	var result = ''
	for i in range(length):
		result += ascii[randi() % ascii.length()]
	return result