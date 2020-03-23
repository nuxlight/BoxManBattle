extends Node2D

var mouse_position

func _ready():
	mouse_position = get_global_mouse_position()

func _physics_process(delta):
	rotation += 10
	print(rotation)
