extends Resource
class_name UpgradeResource

@export var upgrade_name := 'money'
@export var max_tier := 3
@export var initial_cost := 10
@export_category('values')
@export var value1 := 50.0

var tier := 0 :
	set(value):
		tier = value
		tier_changed.emit()

signal tier_changed
