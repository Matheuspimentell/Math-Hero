extends BoxContainer

@export_placeholder("option name...") var option_name: String
@onready var text_label = $option_value
@onready var has_saved_value = GameManager.tattack_options.has(self.name)

func _ready():
	text_label.text = GameManager.tattack_options[self.name] if has_saved_value else ''

func focus_text() -> void:
	text_label.grab_focus()

func unfocus_text() -> void:
	text_label.release_focus()

func save_value() -> void:
	GameManager.tattack_options[option_name] = text_label.text