extends Node

const POPUP = preload("uid://bklkqhs1ruqje")

var skill_tree = []
var money := 0 :
	set(value):
		money = value
		money_changed.emit()

signal money_changed

func popup(pos, text):
	var cl = POPUP.instantiate()
	cl.global_position = pos
	cl.get_node("Label").text = text
	cl.target_pos = scene().get_node('%popup_target').global_position
	scene().add_child(cl)
	
	return cl

func scene():
	return get_tree().current_scene

func tick():
	return Time.get_ticks_msec()/1000.0

func play(sound_name):
	var sound = AudioStreamPlayer.new()
	sound.process_mode = Node.PROCESS_MODE_ALWAYS
	sound.stream = load('res://sounds/%s.mp3' % sound_name)
	sound.volume_linear = 0.5
	if sound_name == 'swish':
		sound.pitch_scale = 0.85
	sound.pitch_scale = randf_range(0.9,1.1)
	get_tree().current_scene.add_child(sound)
	sound.play.call_deferred()
	await sound.finished
	sound.queue_free()
