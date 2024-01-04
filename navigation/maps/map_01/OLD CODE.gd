extends Node


## OLD ENTITY CODE

#extends Area2D
#
#@export var movement_speed = 200;
#
#var path = []
#
#var map;
#
#func _ready():
#	pass # Replace with function body.
#
#func _process(delta):
#	var walk_distance = movement_speed * delta
#	move_along_path(walk_distance)
#
#func actor_setup():
#	await get_tree().physics_frame
#
#func move_along_path(distance):
#	var last_position = position 
#	while path.size():
#		var distance_between_postions = last_position.distance_to(path[0])
#		if distance <= distance_between_postions:
#			position = last_position.lerp(path[0], distance / distance_between_postions)
#			return
#		distance -= distance_between_postions
#		last_position = path[0]
#		path.remove_at(0)
#	position = last_position
#	set_process(false)
#
#func _unhandled_input(event):
#	if not event.is_action_pressed("click"):
#		return
#	print(get_local_mouse_position())
#	_update_navigation_path(position, get_local_mouse_position())


#func _update_navigation_path(end_position):
#	var start_position = position
#	# map_get_path is part of the avigation2DServer class.
#	# It returns a PoolVector2Array of points that lead you
#	# from the start_position to the end_position.
#	path = NavigationServer2D.map_get_path(map,start_position, end_position, true)
#	# The first point is always the start_position.
#	# We don't need it in this example as it corresponds to the character's position.
#	path.remove_at(0)
#	set_process(true)
#
#func set_map(newMap):
#	map = newMap

