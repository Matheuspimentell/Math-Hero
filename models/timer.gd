extends Node2D

# Variables
@onready var timer_label = $Label
var current_time: float

func _ready():
	if not TimeAttackManager.elapsed_time:
		current_time = 0.0
	else:
		current_time = TimeAttackManager.elapsed_time

func _process(delta):
	current_time += delta
	var ms = fmod(current_time, 1) * 1000
	var sec = fmod(current_time, 60)
	var minutes = fmod(current_time, 3600) / 60
	timer_label.text = "%03d:%02d.%03d" % [minutes, sec, ms]

func save_time():
	TimeAttackManager.elapsed_time = current_time
