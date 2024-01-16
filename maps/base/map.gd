class_name BasicMap
extends Node2D

@export var maximum_completion_time: int = 5
@export var _winning_condition: String = 'REACH DESTINATION'

@onready var _navmesh: NavigationRegion2D
@onready var logic_timer: Timer = $LogicTimer

var _map
var _entity_data: Array = []
var _object_data: Array = []
var _is_debug_mode: bool = false

signal plot_path
signal mouse_click_movement
signal mouse_click_shoot
signal space_damage
signal map_stop
signal entity_data
signal object_data

func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	_emit_navmesh_children_data()
	call_deferred("_setup_navserver")
	
func start_simulation():
	logic_timer.start()
	

func set_debug_mode(is_debug_mode: bool):
	_is_debug_mode = is_debug_mode

func _unhandled_input(event):
	if _is_debug_mode:
		if event.is_action_pressed("click"):
			mouse_click_movement.emit(get_global_mouse_position())
			return
		elif event.is_action_pressed("secondary_click"):
			mouse_click_shoot.emit(get_global_mouse_position())
		elif event.is_action_pressed("space_pressed"):
			space_damage.emit()
		elif event.is_action("v_pressed"):
			plot_path.emit()

func _emit_navmesh_children_data():
	var navmesh_children = _navmesh.get_children()
	var new_object_data: Array = []
	var new_entity_data: Array = []
	for child in navmesh_children:
		if child.has_method('get_type'):
			if child.get_type() == 'obstacle':
				new_object_data.append(_format_object_data(child as Obstacle))
			if child.get_type() == 'goal':
				new_object_data.append(_format_goal_data(child as Goal))
			if ['mech','turret'].has(child.get_type()):
				new_entity_data.append(_format_entity_data(child))
	if _object_data != new_object_data:
		_object_data = new_object_data
		object_data.emit(_object_data)
	if _entity_data != new_entity_data:
		_entity_data = new_entity_data
		entity_data.emit(_entity_data)

func _format_goal_data(goal: Goal):
	var goal_type = "Type: " + goal.get_type().capitalize()
	var goal_position = "Position: { x: " + str(int(goal.global_position.x)) + ", y: " + str(int(goal.global_position.y)) + " }"
	return {'name': goal.name, 'data': [ goal_type, goal_position] }

func _format_object_data(object: Obstacle):
	var object_type = "Type: " + object.get_type().capitalize()
	var object_size = "Size: { x: " + str(int(object.get_size().x)) + ", y: " + str(int(object.get_size().y)) + " }"
	var object_position = "Position: { x: " + str(int(object.global_position.x)) + ", y: " + str(int(object.global_position.y)) + " }"
	return {'name': object.name, 'data': [ object_type, object_size, object_position] }

func _format_entity_data(entity: Node):
	var entity_type = "Type: " + entity.get_type().capitalize()
	var entity_hostile = "Hostile: " + str(!entity.get_is_player_controlled())
	var entity_position = "Position: { x: " + str(int(entity.global_position.x)) + ", y: " + str(int(entity.global_position.y)) + " }"
	return {'name': entity.name, 'data': [ entity_type, entity_hostile, entity_position ]}

func _setup_navserver():

	# create a new navigation map
	_map = NavigationServer2D.map_create()
	NavigationServer2D.map_set_active(_map, true)
	NavigationServer2D.map_set_cell_size(_map, 40)
	
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
	
func on_map_end(result: String, reason: String):
	map_stop.emit(result, reason)
	get_tree().paused = true
	
func _match_winning_condition(win_cause: String) -> void:
	match win_cause:
		_winning_condition:
			on_map_end('SUCCESS', _winning_condition)

func _on_go_to_condition_goto_condition_met():
	_match_winning_condition('REACH DESTINATION')

func _on_ai_data_collector_ai_all_entities_destroyed():
	_match_winning_condition('DESTROY ALL HOSTILES')

func _on_ai_data_collector_pc_all_entities_destroyed():
	on_map_end('LOST', 'ALL PLAYER CONTROLLED ENTITIES DIED')
	

func _on_logic_timer_timeout():
	_emit_navmesh_children_data()
