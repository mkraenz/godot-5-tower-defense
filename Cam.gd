extends Camera2D

var speed := 10.0
const follow_speed := 5.0
onready var initial_position = position
onready var bottom_right = Vector2(limit_right - initial_position.x, limit_top - initial_position.y)
onready var target_position = position


func _unhandled_input(_event: InputEvent) -> void:	
	var input_vec = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_vec != Vector2.ZERO:
		target_position += input_vec * speed
		target_position.x = max(target_position.x, initial_position.x)
		target_position.y = max(target_position.y, initial_position.y)
		target_position.x = min(target_position.x, bottom_right.x)
		target_position.y = min(target_position.y, bottom_right.y)

func _physics_process(delta: float) -> void:
	position = position.linear_interpolate(target_position, delta * follow_speed)


# cam position is centered in the screen, otherwise it won't move... Thus correcting by the initial offset.
func zero_based_position() -> Vector2:
	return position - initial_position
