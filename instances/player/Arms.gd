extends Sprite

var mouse_directon
	
func _physics_process(delta):
	mouse_directon = get_global_mouse_position()
	look_at(mouse_directon)
