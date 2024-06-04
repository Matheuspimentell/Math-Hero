extends Sprite2D

@onready var timer_label = $CenterContainer/Label
var current_time: float

func _ready():
	current_time = 0.0

# Use a signal from password screen to stop timer and get elapsed time similarly to the function below
func _input(_event):
	if Input.is_action_just_pressed('accept'):
		print("%03d:%02d.%03d" % [fmod(current_time,3600)/60,fmod(current_time,60),fmod(current_time,1)*1000])

func _process(delta):
	current_time += delta
	var ms = fmod(current_time, 1) * 1000
	var sec = fmod(current_time, 60)
	var minutes = fmod(current_time, 3600) / 60
	timer_label.text = "%03d:%02d.%03d" % [minutes, sec, ms]
