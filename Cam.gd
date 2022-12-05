extends Camera2D

var speed := 5.0
const follow_speed := 5.0
onready var initial_position = get_camera_screen_center()
onready var target_position = position

func _physics_process(delta: float) -> void:
	next_target_position() 
	
	position = position.linear_interpolate(target_position, delta * follow_speed)
	
func next_target_position():
	# input handling done in physics process and not _unhandled_input for immediate and smooth movement
	var input_vec = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_vec != Vector2.ZERO:
		target_position += input_vec * speed
		target_position.x = max(target_position.x, limit_left + initial_position.x)
		target_position.y = min(target_position.y, limit_bottom - initial_position.y)
		target_position.x = min(target_position.x, limit_right - initial_position.x)
		target_position.y = max(target_position.y, limit_top + initial_position.y)

# cam position is centered in the screen, otherwise it won't move... Thus correcting by the initial offset. And for whatever reason, get_camera_screen_center() also didn't work (maybe bc of smoothing?)
func zero_based_position() -> Vector2:
	return position - initial_position
