extends Area2D

export var damage := 1.0

onready var cooldown := $DamageCooldown

# collision layers/masks setup so that only ground_enemies are being detected
var bodies_in_range := []

func _on_Spikes_body_entered(body: Node2D) -> void:
	bodies_in_range.append(body)

func _on_Spikes_body_exited(body: Node2D) -> void:
	bodies_in_range.erase(body)

func _physics_process(_delta: float) -> void:
	if len(bodies_in_range) > 0 && cooldown.is_stopped():
		attack(bodies_in_range)

func attack(targets: Array):
	for target in targets:
		target.take_damage(damage)
	cooldown.start()

func _on_DamageCooldown_timeout():
	attack(bodies_in_range)
