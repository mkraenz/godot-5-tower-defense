extends Camera2D

var speed = 5
onready var initial_position = position
onready var bottom_right = Vector2(limit_right - initial_position.x, limit_top - initial_position.y)

func _unhandled_input(_event: InputEvent) -> void:	
	var input_vec = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_vec != Vector2.ZERO:
		position += input_vec * speed
		position.x = max(position.x, initial_position.x)
		position.y = max(position.y, initial_position.y)
		position.x = min(position.x, bottom_right.x)
		position.y = min(position.y, bottom_right.y)

# cam position is centered in the screen, otherwise it won't move... Thus correcting by the initial offset.
func zero_based_position() -> Vector2:
	return position - initial_position
