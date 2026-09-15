extends HBoxContainer

@export var initial_timer := 10.0

@onready var timer := initial_timer

func update_text():
	$Label.text = str(
		round(timer*10.0)/10.0
	)

func _ready() -> void:
	update_text()

func _on_timer_timeout() -> void:
	update_text()
	timer -= 0.1
