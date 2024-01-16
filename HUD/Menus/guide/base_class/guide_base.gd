class_name GuideBase
extends VBoxContainer

@export var title: String = ''
@export_multiline var text: String = ''
@export var textview_size: Vector2 = Vector2(0, 300)

@onready var rich_text: RichTextLabel = $GuideBaseRichTextLabel
@onready var base_title: Label = $GuideBaseTitle

func _ready():
	if rich_text && rich_text.text != text:
		rich_text.set_custom_minimum_size(textview_size)
		rich_text.text = text
	if base_title && base_title.text != title:
		base_title.text = title
