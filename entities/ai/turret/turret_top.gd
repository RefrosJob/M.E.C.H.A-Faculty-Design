extends Node2D

@onready var front_marker = $TurretTopSprite/TurretFrontMarker

signal fire_weapons

func get_turret_front_marker_position():
	if front_marker:
		return front_marker.global_position

func fire_weaponary():
	fire_weapons.emit(global_rotation)
