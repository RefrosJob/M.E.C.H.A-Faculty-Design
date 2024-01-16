class_name GameRenderer
extends Node

signal render_stop

@export var debug_mode = false

@onready var viewport = %SubViewport
@onready var game_end_view: GameEndView = %GameEndView
@onready var entity_list_container = %EntityListScrollVContainer
@onready var object_list_container = %ObjectListScrollVContainer
@onready var data_label: Label = %DataNameLabel
@onready var data_scroll_label: Label = %DataScrollLabel
@onready var guide: Guide = %Guide
@onready var console_log_label: RichTextLabel = $GameAspectRatioContainer/GameScreenMargin/HudHContainer/HudPanelRight/BottomPanelMargin/BottomPanelHContainer/MarginContainer2/ConsoleLogLabel
@onready var code_edit = %CodeEdit
@onready var simulation_timer: Timer = $SimulationTimer

var _curr_map: BasicMap
var _guide_data: Array


func _ready():
	load_file()

func load_scene(path: String, parent : Node) -> Node:
	if ResourceLoader.exists(path) :
		_curr_map = ResourceLoader.load(path).instantiate()
		_curr_map.set_debug_mode(debug_mode)
		_curr_map.map_stop.connect(_on_map_result)
		_curr_map.entity_data.connect(_on_map_entity_data)
		_curr_map.object_data.connect(_on_map_object_data)
		simulation_timer.set_wait_time(_curr_map.maximum_completion_time)
		if _curr_map :
			parent.add_child(_curr_map)
	return _curr_map
	
	
func load_file():
	var file = FileAccess.open('res://node/src/gameProcess/main.ts', FileAccess.READ)
	code_edit.text = file.get_as_text()
	file.close()

func instantiate_map_by_name(map_name: String):
	load_scene("res://maps/" + map_name + '/'+ map_name + '.tscn', viewport)

func toggle_visibility(is_visible):
	var children = self.get_children()
	for child in children:
		if child.has_method("set_visible"):
			child.set_visible(is_visible)
	
func _on_map_result(result: String, reason: String):
	game_end_view.set_text_data(result, reason, str(int(simulation_timer.wait_time - simulation_timer.time_left)))
	game_end_view.show()
	
func _on_map_exit():
	toggle_visibility(false)
	render_stop.emit()
	_curr_map.queue_free()
	
func _clear_entity_list():
	for node in entity_list_container.get_children():
		entity_list_container.remove_child(node)
		node.queue_free()
		
func _clear_object_list():
	for node in object_list_container.get_children():
		object_list_container.remove_child(node)
		node.queue_free()
	
func _on_map_entity_data(entity_data: Array):
	_clear_entity_list()
	for entity in entity_data:
		var entity_list_button: Entity_List_Button = load('res://hud/ui/buttons/entity_list_button/entity_list_button.tscn').instantiate()
		entity_list_button.set_text(entity.name)
		entity_list_button.set_data(entity)
		entity_list_button.button_update.connect(_on_entity_list_button_updated)
		entity_list_button.chosen_entity.connect(list_data_update)
		entity_list_container.add_child(entity_list_button)

func _on_map_object_data(object_data: Array):
	_clear_object_list()
	for object in object_data:
		var entity_list_button: Entity_List_Button = load('res://hud/ui/buttons/entity_list_button/entity_list_button.tscn').instantiate()
		entity_list_button.set_text(object.name)
		entity_list_button.set_data(object)
		entity_list_button.button_update.connect(_on_object_list_button_updated)
		entity_list_button.chosen_entity.connect(list_data_update)
		object_list_container.add_child(entity_list_button)

func _on_entity_list_button_updated(entity):
	if data_label.text != entity.name:
		return
	list_data_update(entity)
	
func _on_object_list_button_updated(object):
	if data_label.text != object.name:
		return
	list_data_update(object)

func list_data_update(structure):
	var full_data: String = ''
	for data in structure.data:
		full_data += data + ' \n'
	data_label.set_text(structure.name)
	data_scroll_label.set_text(full_data)

func _on_game_end_view_on_back_to_menu_pressed():
	_on_map_exit()

func _on_back_button_pressed():
	_on_map_exit()

func _on_main_menu_guide_data(guide_data: Array):
	_guide_data = guide_data
	

func _on_api_launcher_console_output(output):
	console_log_label.text = output


func _on_help_button_pressed():
	if guide.is_visible():
		guide.hide()
		return
	guide.textview_size = Vector2(0, 150)
	if guide._guide_list.size() == 0:
		guide.add_menu_options(_guide_data)
	guide.show()


func _on_start_button_button_pressed():
	console_log_label.text = ''
	save_file()
	simulation_timer.start()
	_curr_map.start_simulation()


func _on_simulation_timer_timeout():
	var map_name = _curr_map.name
	_curr_map.queue_free()
	await _curr_map.tree_exited
	_curr_map = null
	instantiate_map_by_name(map_name)
	
func save_file():
	var file = FileAccess.open('res://node/src/gameProcess/main.ts', FileAccess.WRITE_READ)
	if code_edit.text == file.get_as_text():
		file.close()
		return
	file.store_string(code_edit.text)
	file.close()


func _on_game_end_view_on_retry_pressed():
	_on_simulation_timer_timeout()
