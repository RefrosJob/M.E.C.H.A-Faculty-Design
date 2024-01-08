class_name GameRenderer
extends Node

signal render_stop

@onready var viewport = %SubViewport
@onready var game_end_view = %GameEndView
@onready var entity_list_container = %EntityListScrollVContainer
@onready var object_list_container = %ObjectListScrollVContainer
@onready var data_label: Label = %DataNameLabel
@onready var data_scroll_label: Label = %DataScrollLabel

var _winning_condition: String = ''
var _curr_map: Node

func load_scene(path: String, parent : Node) -> Node:
	if ResourceLoader.exists(path) :
		_curr_map = ResourceLoader.load(path).instantiate()
		_curr_map.map_stop.connect(_on_map_result)
		_curr_map.entity_data.connect(_on_map_entity_data)
		_curr_map.object_data.connect(_on_map_object_data)
		self._winning_condition = _curr_map.get_winning_condition()
		if _curr_map :
			parent.add_child(_curr_map)
	return _curr_map

func instantiate_map_by_name(map_name: String):
	load_scene("res://navigation/maps/" + map_name + '/'+ map_name + '.tscn', viewport)

func toggle_visibility(is_visible):
	var children = self.get_children()
	for child in children:
		child.set_visible(is_visible)
	
func _on_map_result(result: String):
	game_end_view.show()
	
func _on_map_exit():
	toggle_visibility(false)
	render_stop.emit()
	_curr_map.queue_free()
	
func _on_map_entity_data(entity_data: Array):
	for entity in entity_data:
		var entity_list_button: Entity_List_Button = load('res://HUD/entity_list_button.tscn').instantiate()
		entity_list_button.set_text(entity.name)
		entity_list_button.set_data(entity)
		entity_list_button.chosen_entity.connect(_on_entity_list_button_pressed)
		entity_list_container.add_child(entity_list_button)
	pass
	
func _on_map_object_data(object_data: Array):
	for object in object_data:
		print(object)
		var entity_list_button: Entity_List_Button = load('res://HUD/entity_list_button.tscn').instantiate()
		entity_list_button.set_text(object.name)
		entity_list_button.set_data(object)
		entity_list_button.chosen_entity.connect(_on_entity_list_button_pressed)
		object_list_container.add_child(entity_list_button)
	pass
	
func _on_entity_list_button_pressed(entity):
	var full_data: String
	for data in entity.data:
		full_data += data + ' \n'
	data_label.set_text(entity.name)
	data_scroll_label.set_text(full_data)
	pass

func _on_object_list_button_pressed(object):
	var full_data: String
	for data in object.data:
		full_data += data + ' \n'
	data_label.set_text(object.name)
	data_scroll_label.set_text(full_data)
	pass

func _on_game_end_view_on_back_to_menu_pressed():
	_on_map_exit()


func _on_back_button_pressed():
	_on_map_exit()
