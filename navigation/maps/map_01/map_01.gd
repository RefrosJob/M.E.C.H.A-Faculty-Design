extends Node2D

signal mouse_click_movement
@onready var game_api: HTTPRequest
@onready var navmesh: NavigationRegion2D
var map
# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("setup_navserver")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _unhandled_input(event):
	if not event.is_action_pressed("click"):
		return
	mouse_click_movement.emit(get_global_mouse_position())

func setup_navserver():

	# create a new navigation map
	map = NavigationServer2D.map_create()
	NavigationServer2D.map_set_active(map, true)
	NavigationServer2D.map_set_cell_size(map, 24)

	# create a new navigation region and add it to the map
	var region = NavigationServer2D.region_create()
	NavigationServer2D.region_set_transform(region, Transform2D())
	NavigationServer2D.region_set_map(region, map)

	# sets navigation mesh for the region
	var navigation_poly = $NavMesh.navigation_polygon
	NavigationServer2D.region_set_navigation_polygon(region, navigation_poly)

	# wait for Navigation2DServer sync to adapt to made changes
	await get_tree().physics_frame

func _on_nav_mesh_child_entered_tree(node):
	self.navmesh = %NavMesh
	$GameApi.set_navmesh(navmesh)

func _on_game_api_ready():
	$GameApi.set_navmesh(navmesh)

func _on_nav_mesh_ready():
	self.navmesh = %NavMesh
