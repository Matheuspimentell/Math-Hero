extends AnimatedSprite2D
class_name NumpadKey



func click():
  self.play("click")
  print("Button %s was clicked!" % self.name)
  
