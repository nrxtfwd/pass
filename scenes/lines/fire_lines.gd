extends Area2D
class_name Lines

@export var color : Color
@export var group_name := 'fire'

func _ready() -> void:
	queue_redraw()
	area_entered.connect(_on_area_entered)

func entered(ball):
	pass

func _draw() -> void:
	var col_shape = $CollisionShape2D
	var shape = col_shape.shape
	var rect = Rect2(
		col_shape.position.x-(shape.size.x*0.5),
		col_shape.position.y-(shape.size.y*0.5),
		shape.size.x,
		shape.size.y
	)
	draw_rect(
		rect,
		color.lerp(Color.BLACK,0.4),
		false,
		25.0
	)
	draw_rect(
		rect,
		color,
		false,
		8.0
	)

func _on_area_entered(area: Area2D) -> void:
	entered(area)
	area.add_to_group(group_name)
