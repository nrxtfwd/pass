extends Area2D

var bounce := 0.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(delta: float) -> void:
	bounce = lerp(bounce, 0.0, delta * 10.0)
	global_position = get_global_mouse_position()
	queue_redraw()

func _draw() -> void:
	var radius = $CollisionShape2D.shape.radius
	draw_circle(
		Vector2.ZERO, radius + 20.0 + (bounce * 14.0),
		 Color.WHITE, false, 5.0
	)
	draw_circle(
		Vector2.ZERO, radius + 20.0 + (bounce * 14.0),
		 Color(1,1,1,bounce*0.5), true, 5.0
	)
