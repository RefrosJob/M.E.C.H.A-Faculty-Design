extends Node2D

@export var max_health = 10
var curr_health: int

signal entity_death
signal entity_taken_damage
signal entity_healed


func _ready():
	curr_health = max_health

func decrease_health(damage: int) -> void:
	curr_health -= damage
	if curr_health < 1:
		entity_death.emit()
	else:
		entity_taken_damage.emit()

func increase_heralth(heal: int) -> void:
	if max_health > curr_health + heal:
		curr_health += heal
	else:
		curr_health = max_health
	entity_healed.emit()
