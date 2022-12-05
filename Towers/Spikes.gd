extends Area2D

export var damage := 1.0
export var costs := 100.0

onready var cooldown := $DamageCooldown
onready var shape := $Shape
onready var tower_detector := $TowerDetector

var is_blueprint = false
var can_be_placed = false

# collision layers/masks setup so that only ground_enemies are being detected
var bodies_in_range := []

func _on_Spikes_body_entered(body: Node2D) -> void:
	bodies_in_range.append(body)

func _on_Spikes_body_exited(body: Node2D) -> void:
	bodies_in_range.erase(body)

func _physics_process(_delta: float) -> void:
	if len(bodies_in_range) > 0 && cooldown.is_stopped():
		attack(bodies_in_range)

func attack(targets: Array) -> void:
	for target in targets:
		target.take_damage(damage)
	cooldown.start()

func _on_DamageCooldown_timeout() -> void:
	attack(bodies_in_range)

func set_collision_disabled(val: bool) -> void:
	shape.disabled = val

func set_transparent_red() -> void:
	modulate = Color(1, 0, 0, 0.3) 

func set_transparent_green() -> void:
	modulate = Color(0, 1, 0, 0.3) 

func turn_into_blueprint() -> void:
	is_blueprint = true
	set_collision_disabled(true)
	update_placeable()

func update_placeable():
	if tower_detector.is_colliding():
		set_cannot_be_placed()
	else:
		set_can_be_placed()

func set_can_be_placed() -> void:
	set_transparent_green()
	can_be_placed = true	

func set_cannot_be_placed() -> void:
	set_transparent_red()
	can_be_placed = false	
