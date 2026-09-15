extends Label

func money_changed():
	text = '$%s' % Global.money

func _ready() -> void:
	money_changed()
	Global.money_changed.connect(money_changed)
