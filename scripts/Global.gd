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
	scene().add_child(cl)
	
	return cl

func scene():
	return get_tree().current_scene
