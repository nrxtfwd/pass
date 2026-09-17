extends Area2D

func _on_area_entered(area: Area2D) -> void:
	area.velocity.x *= -1
