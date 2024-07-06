extends BoxContainer

@onready var text_label = $option_value

func focus_text() -> void:
	text_label.grab_focus()

func unfocus_text() -> void:
	text_label.release_focus()
