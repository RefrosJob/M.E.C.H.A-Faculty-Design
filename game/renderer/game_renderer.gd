extends Node

signal render_stop

@onready var viewport = %SubViewport
@onready var game_end_view = %GameEndView

var _winning_condition: String = ''
var _curr_map: Node


func _on_button_pressed():
	print('WORKS')
	pass # Replace with function body.

func load_scene(path: String, parent : Node) -> Node:
	if ResourceLoader.exists(path) :
		_curr_map = ResourceLoader.load(path).instantiate()
		_curr_map.map_stop.connect(_on_map_result)
		self._winning_condition = _curr_map.get_winning_condition()
		if _curr_map :
			parent.add_child(_curr_map)
	return _curr_map

func instantiate_map_by_name(map_name: String):
	load_scene("res://navigation/maps/" + map_name + '/'+ map_name + '.tscn', viewport)

func toggle_visibility(is_visible):
	var children = self.get_children()
	children[0].set_visible(is_visible)
	
func _on_map_result(result: String):
	print(result)
	game_end_view.show()
	
func _on_map_exit():
	toggle_visibility(false)
	render_stop.emit()
	_curr_map.queue_free()
	


func _on_game_end_view_on_back_to_menu_pressed():
	_on_map_exit()
