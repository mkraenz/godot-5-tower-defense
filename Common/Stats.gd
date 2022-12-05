extends Node

signal health_changed
signal no_health

export var max_health := 3.0
export var health := 3.0 setget set_health
export var damage := 1.0

func set_health(val: float) -> void:
	var is_unchanged = val == health
	if is_unchanged:
		return
	var prev = health
	health = min(val, max_health)
	emit_signal("health_changed", {"diff": health - prev})
	if health <= 0:
		emit_signal("no_health")
