class_name Guide
extends MarginContainer

@onready var _guide_options = $MenuOptionsMargin/GuideVBoxContainer/HBoxContainer/ScrollContainer/GuideOptions
@onready var _guide_container = $MenuOptionsMargin/GuideVBoxContainer/HBoxContainer/GuideContainer
var textview_size: Vector2 = Vector2(0, 300)

var _guide_list: Array

func add_menu_options(new_guide_list: Array) -> void:
	_guide_list = new_guide_list.filter(_filtration)
	if _guide_list.size() && _guide_options:
		for guide_name in _guide_list:
			var guide_button: GuideButton = load('res://hud/ui/buttons/guide_tab_button/guide_tab_button.tscn').instantiate()
			guide_button.set_text(guide_name.capitalize())
			guide_button.set_flat(true)
			guide_button.set_theme(load('res://HUD/Themes/MainMenu/main_menu.tres'))
			guide_button.set_default_cursor_shape(CURSOR_POINTING_HAND)
			guide_button.set_text_alignment(HORIZONTAL_ALIGNMENT_LEFT)
			guide_button.guide_button_press.connect(_on_guide_button_pressed)
			_guide_options.add_child(guide_button)
		_on_guide_button_pressed(_guide_list[0])

func _filtration(guide: String):
		var path_without_identifier = "res://maps/{map_name}/guide/guide.tscn"
		var full_path = path_without_identifier.format({'map_name': guide.to_lower().replace(' ', '_') }) 
		return load(full_path)

func _on_guide_button_pressed(guide_name: String) -> void:
	var curr_guide = _guide_container.get_child(0)
	if guide_name.length():
		if curr_guide:
			curr_guide.queue_free()
		var path_without_identifier = "res://maps/{map_name}/guide/guide.tscn"
		var full_path = path_without_identifier.format({'map_name': guide_name.to_lower().replace(' ', '_') })
		if full_path:
			var guide = load(full_path)
			if guide:
				var inst_guide = guide.instantiate()
				inst_guide.textview_size = textview_size
				inst_guide.show()
				_guide_container.add_child(inst_guide)


func _on_main_menu_guide_data(new_guide_list: Array):
	add_menu_options(new_guide_list)
