extends Area2D

@export var impulse: float = 500.0
@export var min_speed: float = 400.0
@export var power_upgrade : UpgradeResource
@export var accuracy_upgrade : UpgradeResource

func _ready() -> void:
	var camera = get_tree().get_first_node_in_group('camera')
	area_entered.connect(_on_area_entered)
	$sprite.flip_h = global_position.x > camera.global_position.x

func randomise(dir):
	var angle := randf_range(-25.0,25.0)
	for i in range(accuracy_upgrade.tier):
		if randf() <= 0.3:
			angle = 0.0
	return dir.rotated(deg_to_rad(angle))

func _on_area_entered(area: Area2D) -> void:
	if "velocity" in area:
		var players = get_tree().get_nodes_in_group("player")
		var valid_players = []
		for p in players:
			if p != self:
				valid_players.append(p)
		
		var power = impulse
		power += power_upgrade.tier*power_upgrade.value1
		if not valid_players.is_empty():
			var nearest = valid_players.pick_random()
			var dir = (nearest.global_position - area.global_position).normalized()
			dir = randomise(dir)
			area.velocity = dir * power
		else:
			var mouse_pos = get_global_mouse_position()
			var dir = (mouse_pos - area.global_position).normalized()
			dir = randomise(dir)
			area.velocity = dir * power
		area.hit(self)
		$AnimationPlayer.stop()
		$AnimationPlayer.play('squash')
		
