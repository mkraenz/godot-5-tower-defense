extends HBoxContainer

onready var label = $Label
onready var timer = $Timer # TODO probably better to use lerp (with cubic interpolation with fixed time)

var target_money = 0.0
var current_money = 0.0

func _on_Timer_timeout() -> void:
    current_money += sign(target_money - current_money)
    label.text = str(current_money)
    if target_money != current_money:
        timer.start()

func init_money(amount: float) -> void:
    target_money = amount
    current_money = amount
    label.text = str(current_money)

func update_money(amount: float):
    target_money = amount
    if timer.is_stopped():
        timer.start()
