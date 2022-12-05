extends Control

onready var nexus = Nexus
onready var money = $MoneyHStack

func _ready() -> void:
    nexus.connect("money_changed", self, "_on_money_changed")
    update_money()

func _on_money_changed(data: Dictionary) -> void:
    update_money()
    var has_spent_money = data["diff"] < 0
    if has_spent_money:
        pass
        # todo play some sound
    else: # i.e. we received money
        pass

func update_money():
    money.update_money(nexus.money)