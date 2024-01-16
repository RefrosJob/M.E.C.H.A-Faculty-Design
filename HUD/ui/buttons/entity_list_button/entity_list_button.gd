class_name Entity_List_Button
extends Button

var data

signal chosen_entity
signal button_update

func _ready():
	button_update.emit(data)

func _on_pressed():
	chosen_entity.emit(data)

func set_data(_data):
	data = _data
