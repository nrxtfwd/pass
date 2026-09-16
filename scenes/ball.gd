extends Area2D

@export var velocity: Vector2 = Vector2.ZERO
@export var decay: float = 200.0
@export var threshold: float = 300.0
@export var impulse: float = 500.0
@export var money_color : Color
@export var crit_color : Color

@export_category('upgrades')
@export var money_upgrade : UpgradeResource
@export var power_upgrade : UpgradeResource
@export var accuracy_upgrade : UpgradeResource

var hovering = false
var hit_cd := 0.0

func hit(player = self):
	var amount = 1
	var is_crit = randf() <= 0.2
	hit_cd = 0.8
	if is_in_group('fire'):
		is_crit = true
	if is_crit:
		amount = randi_range(2,3)
	amount += money_upgrade.tier
	$AnimationPlayer.stop()
	$AnimationPlayer.play('squash')
	Global.money += amount
	var popup = Global.popup(player.global_position,'$%s' % amount)
	popup.modulate = money_color if !is_crit else crit_color
	if player != self:
		for group in get_groups():
			remove_from_group(group)

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
	$fire.emitting = is_in_group('fire')
	if velocity.length() > threshold:
		$sprite.rotation += deg_to_rad(3.0)
	$GPUParticles2D.emitting = velocity.length() > threshold
	$sprite.modulate = Color.GRAY if velocity.length() > threshold else Color.WHITE
	velocity = velocity.move_toward(Vector2.ZERO, decay * delta)
	position += velocity * delta
	hit_cd -= delta
	if hovering:
		if hit_cd <= 0.0:
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
				var power = impulse
				power += power_upgrade.tier*power_upgrade.value1
				velocity = dir * (power)
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
