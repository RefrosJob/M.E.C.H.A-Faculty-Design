extends Node

@onready var viewport = %SubViewport

func _on_button_pressed():
	print('WORKS')
	pass # Replace with function body.

func load_scene(path: String, parent : Node) -> Node:
	var result: Node
	if ResourceLoader.exists(path) :
		result = ResourceLoader.load(path).instantiate()
		if result :
			parent.add_child(result)
	return result

func instantiate_map_by_name(map_name: String):
	load_scene("res://navigation/maps/" + map_name + '/'+ map_name + '.tscn', viewport)

func toggle_visibility():
	var children = self.get_children()
	if children[0].is_visible():
		children[0].hide()
		return
	children[0].show()
