extends Button

@export var upgrade_resource : UpgradeResource

func get_cost():
	return (
		upgrade_resource.tier*10
	)+upgrade_resource.initial_cost

func update_text():
	%upgrade_label.text = '%s %s \n$%s' % [
		upgrade_resource.upgrade_name, upgrade_resource.tier,
		get_cost()
	]

func _ready():
	update_text()
	pressed.connect(_on_pressed)
	upgrade_resource.tier_changed.connect(update_text)

func _on_pressed():
	if Global.money < get_cost():
		return
	Global.money -= get_cost()
	upgrade_resource.tier += 1
