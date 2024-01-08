extends Node

var navmesh: NavigationRegion2D

func set_navmesh(new_navmesh: NavigationRegion2D):
	navmesh = new_navmesh


func _on_game_api_new_command_signal(command):
	if navmesh && navmesh.get_children().size():
		match command['command'].keys()[0]:
			'moveTo':
				var target = navmesh.get_node(command['entityName'])
				var velocity = Vector2(float(command.command['moveTo'].x), float(command.command['moveTo'].y))
				target.move2(velocity)
