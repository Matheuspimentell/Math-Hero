extends AnimatedSprite2D
class_name NumpadKey
var password: Label
var click_sound: AudioStreamPlayer
var error_sound: AudioStreamPlayer

func _ready():
  password = get_node(^"../../password_box/password")
  click_sound = get_node(^"../../sfx_controller/click")
  error_sound = get_node(^"../../sfx_controller/error")

func click():
  if self.name == 'backspace':
    if(password.text.length() >= 1):
      password.text = password.text.erase(password.text.length()-1, 1)
      click_sound.play()
    else:
      error_sound.play()
  else:
    click_sound.play()
    password.text += self.name
  
