extends Control

var textview_size: Vector2 = Vector2(0, 300)
# Called when the node enters the scene tree for the first time.
func _ready():
	$GuideBase.textview_size = textview_size
