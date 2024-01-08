extends Node

@onready var navmesh = %NavMesh

signal pc_entity_positions

func _process(delta):
	pc_entity_positions.emit(get_pc_entity_positions())
	pass

func get_pc_entity_positions() -> PackedVector2Array:
	var entitiy_position_list: PackedVector2Array = []
	if navmesh:
		var navmesh_nodes = navmesh.get_children()
		for node in navmesh_nodes:
			if node.has_method('get_is_player_controlled'):
				entitiy_position_list.append(node.global_position)
	return entitiy_position_list
