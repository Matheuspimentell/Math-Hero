extends Node

@onready var viewportContainer = $SubViewportContainer
@onready var subViewport = $SubViewportContainer/SubViewport
@onready var screenResolution = get_viewport().size

var scaling: Vector2

#Scale x and y evenly
func _ready():
	self.size = get_viewport().size
	scaling = screenResolution/subViewport.size

	# Calculate scaling vector
	if(scaling.x > scaling.y):
		scaling.x = scaling.y
	else:
		scaling.y = scaling.x

	# Calculate margins
	var marginX = (get_viewport().size.x-(272*scaling.x))/2
	var marginY = (get_viewport().size.y-(160*scaling.y))/2

	# Center the pixel art
	viewportContainer.position.x += marginX
	viewportContainer.position.y += marginY
	viewportContainer.scale = scaling
