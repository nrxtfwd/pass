extends Node2D

@export var speed := 100.0

var time_elapsed := 0.0
var target_pos : Vector2
var amount := 0

func _process(delta: float) -> void:
	time_elapsed += delta
	global_position = global_position.lerp(
		target_pos,time_elapsed/8.0
	)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Global.money += amount
