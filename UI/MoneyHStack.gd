extends HBoxContainer

onready var label = $Label

func update_money(amount: float):
    label.text = str(amount)
