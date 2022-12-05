extends KinematicBody2D

onready var nexus = Nexus
onready var attack_cooldown = $AttackCooldown

export var damage = 1.0
const acceleration = 200
const max_speed = 100

enum State {
	Walk,
	Attack
}

var direction = Vector2.LEFT
var velocity = Vector2.ZERO
var state = State.Walk

func _physics_process(delta: float) -> void:
	match state:
		State.Walk:
			velocity = velocity.move_toward(direction * max_speed, delta * acceleration)
			velocity = move_and_slide(velocity)
			if position.x < 50:
				state = State.Attack
				print("switching to attack state")
		State.Attack:
			if attack_cooldown.is_stopped():
				attack_cooldown.start()

func _on_AttackCooldown_timeout() -> void:
	attack()

func attack() -> void:
	nexus.take_damage(damage)
	attack_cooldown.start()
