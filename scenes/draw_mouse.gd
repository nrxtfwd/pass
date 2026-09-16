extends Node2D

var radius := 0.0
var bounce := 0.0

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()

func draw_mouse(_radius,_bounce):
	radius = _radius
	bounce = _bounce
	queue_redraw()

func _draw() -> void:
	draw_circle(
		Vector2.ZERO, radius*0.5 + 20.0 + (bounce * 14.0),
		 Color.WHITE, false, 5.0
	)
	draw_circle(
		Vector2.ZERO, radius*0.5 + 20.0 + (bounce * 14.0),
		 Color(1,1,1,bounce*0.5), true
	)
