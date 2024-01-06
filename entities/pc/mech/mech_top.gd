extends Node2D

func fire_weaponary():
	$MechBody/AutoCannon.shoot(global_rotation)
	$MechBody/AutoCannon2.shoot(global_rotation)


func _on_entity_pc_mech_shoot_cannon():
	fire_weaponary()
	pass # Replace with function body.
