extends CharacterBody2D

var projectile = preload("res://entities/properties/weapons/projectile.tscn")

func get_parent_map(node):
	if node.name.contains('Map'):
		return node
	return get_parent_map(node.get_parent())
		

func shoot(_rotation):
	var projectile_instance = projectile.instantiate()
	print('Marker pos', $Marker2D.get_global_position())
	projectile_instance.start($Marker2D.get_global_position(), _rotation)
	get_parent_map(get_parent()).add_child(projectile_instance)
	
