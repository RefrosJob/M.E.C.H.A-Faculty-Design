extends AspectRatioContainer

signal map_chosen

@onready var confirm_leave = $ConfirmLeave
@onready var scenario_picker_container = %ScenarioPicker
@onready var menu_options = %MenuOptions

func _ready():
	_fill_menu_options()

func clear_selections():
	if scenario_picker_container.is_visible():
		scenario_picker_container.hide()
		
func _fill_menu_options():
	var map_list: PackedStringArray = _get_map_list()
	if map_list.size():
		for map_name in map_list:
			var map_button: Button = load('res://HUD/map_button.tscn').instantiate()
			map_button.set_text(map_name.capitalize())
			map_button.set_flat(true)
			map_button.set_theme(load('res://HUD/Themes/MainMenu/main_menu.tres'))
			map_button.set_default_cursor_shape(2)
			map_button.set_text_alignment(0)
			map_button.map_button_press.connect(_on_map_button_pressed)
			menu_options.add_child(map_button)
			

func _get_map_list():
	var maps_direcory = DirAccess.open('res://navigation/maps/')
	return maps_direcory.get_directories()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit()

func _on_exit_pressed():
	confirm_leave.show()

func _on_confirm_leave_confirmed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)

func _on_play_pressed():
	if scenario_picker_container.is_visible():
		scenario_picker_container.hide()
		return
	scenario_picker_container.show()

func _on_map_button_pressed(map_name: String):
	map_chosen.emit(map_name.to_lower().replace(' ', '_'))

func _on_map_01_pressed():
	map_chosen.emit('map_01')
