class_name Obstacle
extends StaticBody2D

var _type = 'obstacle'

func get_size():
	return $ColorRect.get_size()

func get_type() -> String:
	return _type
