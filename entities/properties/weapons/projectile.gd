extends CharacterBody2D


@export var speed = 700
@export var damage = 5

func start(_position, _direction):
	rotation = _direction
	position = _position
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.get_collider().has_method('hit'):
			collision.get_collider().hit(damage)
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
