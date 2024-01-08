extends CharacterBody2D

@export var variant = 'pc'

@onready var turret_sprite: Sprite2D = $CannonSprite
@onready var turret_face_marker: Marker2D = $CannonFaceMarker

var projectile = preload("res://entities/properties/weapons/projectile.tscn")

func _ready():
	match variant:
		'ai':
			var image = Image.load_from_file("res://assets/entities/mech/autocannon_ai.png")
			var texture = ImageTexture.create_from_image(image)
			turret_sprite.set_texture(texture)

func get_parent_map(node):
	if node.name.contains('Map'):
		return node
	return get_parent_map(node.get_parent())
		

func shoot(_rotation):
	var projectile_instance = projectile.instantiate()
	projectile_instance.start(turret_face_marker.get_global_position(), _rotation)
	get_parent_map(get_parent()).add_child(projectile_instance)
	
