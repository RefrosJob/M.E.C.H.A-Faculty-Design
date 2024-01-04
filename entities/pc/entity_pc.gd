extends CharacterBody2D

var type: String = 'mech'
var is_player_controlled: bool = true
@export var movement_speed: float = 0

var movement_target_position: Vector2;

func _ready():
	if movement_speed == 0:
		movement_speed = 300
	pass
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision || global_position.distance_to(movement_target_position) < $ColorRect.size.x * 0.2:
		velocity = Vector2(0, 0)
	
	
func get_current_destination():
	if global_position.distance_to(movement_target_position) < $ColorRect.size.x * 0.2:
		return global_position
	return movement_target_position

func _on_map_01_mouse_click_movement(movement_target: Vector2):
	movement_target_position = movement_target
	var direction = (movement_target - global_position).normalized()
	velocity = direction * movement_speed
	pass 
	
func get_type():
	return self.type
	
func get_is_player_controlled():
	return self.is_player_controlled
