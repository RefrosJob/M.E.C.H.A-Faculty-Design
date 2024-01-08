class_name Entity_List_Button
extends Button

var data

signal chosen_entity

func _on_pressed():
	chosen_entity.emit(data)

func set_data(_data):
	data = _data
