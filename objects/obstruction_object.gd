class_name Obstacle
extends StaticBody2D

var _type = 'obstacle'

func get_size():
	return $Sprite2D.get_rect().size

func get_type() -> String:
	return _type
