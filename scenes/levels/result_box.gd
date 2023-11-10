extends LineEdit

func _ready():
	grab_focus()

func _process(_delta):
	if Input.is_action_pressed("accept"):
		text_submitted.emit(self.text)
