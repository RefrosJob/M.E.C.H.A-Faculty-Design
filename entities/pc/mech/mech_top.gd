extends Node2D

signal fire_weapons

func fire_weaponary():
	fire_weapons.emit(global_rotation)


func _on_entity_pc_mech_shoot_cannon():
	fire_weaponary()
	pass # Replace with function body.
