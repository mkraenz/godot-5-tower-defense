extends Node

signal health_changed(data)
signal no_health
signal money_changed(data)

var money := 100.0 setget set_money
var max_health := 100.0
var health := 100.0 setget set_health

func set_health(val: float) -> void:
	var prev = health
	health = min(val, max_health)
	emit_signal("health_changed", { "diff": health - prev })
	print("nexus: health changed: ", health, "/", max_health)
	if health <= 0:
		emit_signal("no_health")
		print("nexus: no health. Game Over")

func take_damage(raw_damage: float) -> void:
	self.health -= raw_damage

func set_money(val: float) -> void:
	var prev = money
	money = max(0, val)
	emit_signal("money_changed", { "diff": money - prev })

func can_buy(costs: float) -> bool:
	return money >= costs

func add_money(raw_money: float) -> void:
	self.money += raw_money