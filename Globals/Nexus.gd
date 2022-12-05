extends Node

signal health_changed
signal no_health

var max_health := 100.0
var health := 100.0 setget set_health

func set_health(val: float) -> void:
	health = min(val, max_health)
	emit_signal("health_changed")
	print("nexus: health changed: ", health, "/", max_health)
	if health <= 0:
		emit_signal("no_health")
		print("nexus: no health. Game Over")

func take_damage(raw_damage: float) -> void:
	self.health -= raw_damage
