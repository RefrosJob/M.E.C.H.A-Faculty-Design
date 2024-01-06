extends Node2D

@onready var _navmesh: NavigationRegion2D

var _map
var _winning_condition: String = 'GOTO'

signal mouse_click_movement
signal mouse_click_shoot
signal space_damage
signal map_stop

func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	call_deferred("setup_navserver")
	
func _unhandled_input(event):
	if event.is_action_pressed("click"):
		mouse_click_movement.emit(get_global_mouse_position())
		return
	elif event.is_action_pressed("secondary_click"):
		mouse_click_shoot.emit(get_global_mouse_position())
	elif event.is_action_pressed("space_pressed"):
		space_damage.emit()
	return 
func setup_navserver():

	# create a new navigation map
	_map = NavigationServer2D.map_create()
	NavigationServer2D.map_set_active(_map, true)
	NavigationServer2D.map_set_cell_size(_map, 24)

	# create a new navigation region and add it to the map
	var region = NavigationServer2D.region_create()
	NavigationServer2D.region_set_transform(region, Transform2D())
	NavigationServer2D.region_set_map(region, _map)

	# sets navigation mesh for the region
	var navigation_poly = $NavMesh.navigation_polygon
	NavigationServer2D.region_set_navigation_polygon(region, navigation_poly)

	# wait for Navigation2DServer sync to adapt to made changes
	await get_tree().physics_frame

func _on_nav_mesh_child_entered_tree(_node):
	self._navmesh = %NavMesh
	$GameApi.set_navmesh(_navmesh)

func _on_game_api_ready():
	$GameApi.set_navmesh(_navmesh)

func _on_nav_mesh_ready():
	self._navmesh = %NavMesh
	
func get_winning_condition():
	return _winning_condition
	
func on_map_end(result: String):
	map_stop.emit(result)
	get_tree().paused = true

func _on_go_to_condition_goto_condition_met():
	match _winning_condition:
		'GOTO':
			print('on map end')
			on_map_end('VICTORY')
