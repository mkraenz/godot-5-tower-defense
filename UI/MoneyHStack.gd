extends HBoxContainer

onready var label = $Label

var target_money = 0.0
var current_money = 0.0
var weight := 0.0
const anim_speed := 1

func _ready() -> void:
    set_physics_process(false)

func _physics_process(delta: float) -> void:
    weight += delta * anim_speed
    weight = clamp(weight, 0, 1)
    current_money = ceil(lerp(current_money, target_money, weight))

    label.text = str(current_money)
    
    if current_money == target_money:
        weight = 0.0
        set_physics_process(false)

func init_money(amount: float) -> void:
    target_money = amount
    current_money = amount
    label.text = str(current_money)

func update_money(amount: float):
    target_money = amount
    set_physics_process(true)