extends Area2D

var collision_count = 0

# TODO: does this still work if one of the towers is a physics body and NOT an area2d?
func _on_TowerCollider_area_entered(_area: Area2D) -> void:
	collision_count += 1

func _on_TowerCollider_area_exited(_area: Area2D) -> void:
	collision_count -= 1

func is_colliding() -> bool:
	return collision_count != 0