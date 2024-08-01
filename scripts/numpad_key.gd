extends Control

@onready var animatedSprite = $AnimatedSprite2D

signal clicked(key: String)

func _ready():
	pass

func _input(event):
	if event.is_action_released(self.name):
		animatedSprite.play("click")
		clicked.emit(self.name)
