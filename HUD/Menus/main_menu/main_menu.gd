class_name MainMenu
extends AspectRatioContainer

signal map_chosen
signal guide_data

@onready var _confirm_leave: ConfirmationDialog = $ConfirmLeave
@onready var _map_picker: MapPicker = $MainMenuMargin/HorisontalMenuContainer/MapPicker
@onready var _guide_container: Guide =  $MainMenuMargin/HorisontalMenuContainer/Guide

func _ready() -> void:
	_set_map_list()

func clear_selections() -> void:
	_map_picker.hide()
	_guide_container.hide()

func _set_map_list() -> void:
	var maps_directory = DirAccess.open('res://maps/')
	var map_directiories = Array(maps_directory.get_directories()).filter(func(directory): return directory != 'base')
	_map_picker.add_menu_options(map_directiories)
	guide_data.emit(map_directiories)

func _notification(what) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit()

func _on_exit_pressed() -> void:
	_confirm_leave.show()

func _on_confirm_leave_confirmed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)

func _on_play_pressed() -> void:
	_guide_container.hide()
	if _map_picker.is_visible():
		_map_picker.hide()
		return
	_map_picker.show()

func _on_guide_pressed() -> void:
	_map_picker.hide()
	if _guide_container.is_visible():
		_guide_container.hide()
		return
	_guide_container.show()
	
