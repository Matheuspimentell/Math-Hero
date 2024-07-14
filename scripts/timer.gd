extends TextureRect

# Variables
@onready var timer_label = $Label
var current_time: float
var _is_running: bool

func _ready():
	#TODO: Get elapsed time from game manager
	current_time = 0.0

func _process(delta):
	if _is_running:
		current_time += delta
		var ms = fmod(current_time, 1) * 1000
		var sec = fmod(current_time, 60)
		var minutes = fmod(current_time, 3600) / 60
		timer_label.text = "%03d:%02d.%03d" % [minutes, sec, ms]

func start_timer() -> void:
	_is_running = true

func stop_timer() -> void:
	_is_running = false

func save_time():
	TimeAttackManager.elapsed_time = current_time
