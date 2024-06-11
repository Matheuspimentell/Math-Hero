extends Node2D

@onready var timer_label = $Label
var current_time: float

func _ready():
	current_time = 0.0

#TODO: Receive end of phase signal, send elapsed time back to main scene
func _input(_event):
	if Input.is_action_just_pressed('accept'):
		print("%03d:%02d.%03d" % [fmod(current_time,3600)/60,fmod(current_time,60),fmod(current_time,1)*1000])

func _process(delta):
	current_time += delta
	var ms = fmod(current_time, 1) * 1000
	var sec = fmod(current_time, 60)
	var minutes = fmod(current_time, 3600) / 60
	timer_label.text = "%03d:%02d.%03d" % [minutes, sec, ms]
