extends Node

var entity_data_list: Array
var object_data_list: Array

var navmesh: NavigationRegion2D

func set_navmesh(new_navmesh: NavigationRegion2D):
	navmesh = new_navmesh

func get_world_data():
	set_object_data()
	var max_size = get_viewport().get_visible_rect().size
	return {'world_size': {'max_x': max_size.x, 'max_y': max_size.y }, 'object_data': object_data_list }

func get_nodes_by_types(types: PackedStringArray):
	if navmesh :
		var nav_mesh_children = navmesh.get_children()
		var node_list = Array()
		
		for node in nav_mesh_children:
			if node.has_method('get_type') && types.has(node.get_type()):
				node_list.append(node)
		
		return node_list
	return []
	
func set_object_data():
	var object_nodes = get_nodes_by_types(['obstacle'])
	var new_object_data_list: Array = Array()
	
	for object in object_nodes:
		var object_global_position = object.global_position
		var object_size= object.get_size()
			
		new_object_data_list.append(
			{
				'name': String(object.name), 
				'position': {'x': round(object_global_position.x), 'y': round(object_global_position.y)},
				'size': {'x': round(object_size.x), 'y':round(object_size.y)}
			})
			
	object_data_list = new_object_data_list
	

func set_entity_data():
	var entity_nodes = get_nodes_by_types(['mech'])
	var new_entity_data_list: Array = Array()
	
	for entity in entity_nodes:
		var entity_global_position = entity.global_position
		var entity_current_destination = entity.get_current_destination()
			
		new_entity_data_list.append(
			{
				'name': String(entity.name), 
				'position': {'x': round(entity_global_position.x), 'y': round(entity_global_position.y)},
				'destination': {'x': round(entity_current_destination.x), 'y':round(entity_current_destination.y)},
				'type': entity.get_type(),
				'is_player_controlled': entity.get_is_player_controlled()
			})
			
	entity_data_list = new_entity_data_list;

func get_full_info():
	set_entity_data()
	var world_data = get_world_data()
	return {'entity_data': entity_data_list, 'world_data': world_data }
