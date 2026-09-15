extends Area2D

@export var velocity: Vector2 = Vector2.ZERO
@export var decay: float = 200.0
@export var threshold: float = 300.0
@export var impulse: float = 500.0

var hovering = false

func hit():
	$AnimationPlayer.stop()
	$AnimationPlayer.play('squash')

func _ready() -> void:
	area_entered.connect(
		func(_area):
			hovering = true
	)
	area_exited.connect(
		func(_area):
			hovering = false
	)

func _process(delta: float) -> void:
	if velocity.length() > threshold:
		$sprite.rotation += deg_to_rad(3.0)
	$GPUParticles2D.emitting = velocity.length() > threshold
	$sprite.modulate = Color.GRAY if velocity.length() > threshold else Color.WHITE
	velocity = velocity.move_toward(Vector2.ZERO, decay * delta)
	position += velocity * delta
	if hovering:
		if velocity.length() <= threshold:
			var players = get_tree().get_nodes_in_group("player")
			if not players.is_empty():
				var nearest = players[0]
				var min_dist = global_position.distance_to(nearest.global_position)
				for p in players:
					var dist = global_position.distance_to(p.global_position)
					if dist < min_dist:
						min_dist = dist
						nearest = p
				var dir = (nearest.global_position - global_position).normalized()
				velocity = dir * impulse
				Global.money += 1
				Global.popup(global_position,'1')
				hit()
				get_tree().get_first_node_in_group('mouse').bounce = 1.0

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	var vp_rect = get_viewport_rect()
	if global_position.x < vp_rect.position.x or global_position.x > vp_rect.end.x:
		velocity.x = -velocity.x
	if global_position.y < vp_rect.position.y or global_position.y > vp_rect.end.y:
		velocity.y = -velocity.y
	if velocity == Vector2.ZERO:
		velocity = (vp_rect.size / 2 - global_position).normalized() * impulse
