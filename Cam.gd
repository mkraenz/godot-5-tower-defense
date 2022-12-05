extends Camera2D

var speed := 5.0
const follow_speed := 5.0
onready var initial_position = position
onready var bottom_right = Vector2(limit_right - initial_position.x, limit_top - initial_position.y)
onready var target_position = position

func _physics_process(delta: float) -> void:
	var input_vec = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_vec != Vector2.ZERO:
		target_position += input_vec * speed
		target_position.x = max(target_position.x, initial_position.x)
		target_position.y = max(target_position.y, initial_position.y)
		target_position.x = min(target_position.x, bottom_right.x)
		target_position.y = min(target_position.y, bottom_right.y)
	position = position.linear_interpolate(target_position, delta * follow_speed)
