extends Node

@onready var navmesh = %NavMesh

signal pc_entity_positions
signal pc_all_entities_destroyed
signal ai_all_entities_destroyed


func _process(_delta):
	pc_entity_positions.emit(get_pc_entity_positions())
	check_destroyed_entities()

func get_pc_entity_positions() -> PackedVector2Array:
	var entity_position_list: PackedVector2Array = []
	if navmesh:
		var navmesh_nodes = navmesh.get_children()
		for node in navmesh_nodes:
			if node.has_method('get_is_player_controlled'):
				entity_position_list.append(node.global_position)
	return entity_position_list

func check_destroyed_entities() -> void:
	var ai_entity_states: Array = []
	var pc_entity_states: Array = []
	if navmesh:
		var navmesh_nodes = navmesh.get_children()
		for node in navmesh_nodes:
			if node.has_method('get_is_player_controlled') && node.has_method('get_is_entity_destroyed'):
				var entity = node
				if entity.get_is_player_controlled():
					pc_entity_states.append(node.get_is_entity_destroyed())
				else:
					ai_entity_states.append(node.get_is_entity_destroyed())
	if ai_entity_states.find(false) == -1:
		ai_all_entities_destroyed.emit()
		return
	if pc_entity_states.find(false) == -1:
		pc_all_entities_destroyed.emit()
		return
