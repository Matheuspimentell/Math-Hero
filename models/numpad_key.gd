extends AnimatedSprite2D
class_name NumpadKey

@export_placeholder('Input Action Name...') var buttonName: String
signal clicked(key: String)

func _input(_event):
  if Input.is_action_just_pressed(buttonName):
    self.play("click")
    clicked.emit(buttonName)
