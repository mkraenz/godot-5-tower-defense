extends HBoxContainer

onready var label := $Label
onready var tween : Tween = $Tween

var target_money = 0.0
var current_money = 0.0 setget set_current_money
const anim_duration := 0.5

func _ready() -> void:
	set_physics_process(false)

func set_current_money(val: float) -> void:
	current_money = ceil(val)
	label.text = str(current_money)

func init_money(amount: float) -> void:
	target_money = amount
	current_money = amount
	label.text = str(current_money)

func update_money(amount: float):
	target_money = amount
	var _a = tween.interpolate_property(self, "current_money", current_money, target_money,  anim_duration, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	var _b = tween.start()
