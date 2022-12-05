extends Control

onready var nexus = Nexus
onready var money = $MoneyHStack

func _ready() -> void:
    nexus.connect("money_changed", self, "_on_money_changed")
    money.init_money(nexus.money)

func _on_money_changed(data: Dictionary) -> void:
    money.update_money(nexus.money)
    var has_spent_money = data["diff"] < 0
    if has_spent_money:
        pass
        # todo play some sound
    else: # i.e. we received money
        pass
