class_name MapPicker
extends MarginContainer

@export var main_menu: MainMenu

@onready var _menu_options = $ScenarioInnerMargin/MarginContainer/ScenarioPickerContainer/ScrollContainer/MenuOptions

func add_menu_options(_map_list: PackedStringArray) -> void:
	if _map_list.size() && _menu_options:
		for map_name in _map_list:
			var map_button: MapButton = load('res://HUD/ui/buttons/map_button/map_button.tscn').instantiate()
			map_button.set_text(map_name.capitalize())
			map_button.set_flat(true)
			map_button.set_theme(load('res://HUD/Themes/MainMenu/main_menu.tres'))
			map_button.set_default_cursor_shape(CURSOR_POINTING_HAND)
			map_button.set_text_alignment(HORIZONTAL_ALIGNMENT_LEFT)
			map_button.map_button_press.connect(_on_map_button_pressed)
			_menu_options.add_child(map_button)

func _on_map_button_pressed(map_name: String) -> void:
	main_menu.map_chosen.emit(map_name.to_lower().replace(' ', '_'))
