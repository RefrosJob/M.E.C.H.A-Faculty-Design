extends CharacterBody2D

@export var movement_speed: float = 0
@onready var _navigation_agent: NavigationAgent2D = $NavigationAgent2D
var type: String = 'turret'
var is_player_controlled: bool = false

var movement_target_position: Vector2;

func _ready():
	call_deferred("actor_setup")

func actor_setup():
	if movement_speed == 0:
		movement_speed = 300
	_navigation_agent.set_max_speed(movement_speed)
	await get_tree().physics_frame
	
func _physics_process(_delta):
	if _navigation_agent.is_navigation_finished():
		return
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = _navigation_agent.get_next_path_position()

	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * movement_speed

	_navigation_agent.set_velocity(new_velocity);
	

func move(velocty: Vector2):
	velocity = velocty
	move_and_slide()
	pass
	
func move2(target: Vector2):
	_navigation_agent.target_position = target
	
func _on_game_scene_mouse_click_movement(movement_target: Vector2):
	_navigation_agent.target_position = movement_target
	pass 

func get_current_destination():
	if _navigation_agent.is_navigation_finished():
		return global_position
	return _navigation_agent.get_final_position()


