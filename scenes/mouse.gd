extends Area2D

@export var draw_mouse : Node2D

var bounce := 0.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(delta: float) -> void:
	bounce = lerp(bounce, 0.0, delta * 10.0)
	global_position = get_global_mouse_position()
	draw_mouse.draw_mouse($CollisionShape2D.shape.radius,bounce)
	
