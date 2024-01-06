extends MarginContainer

signal map_chosen

@onready var confirm_leave = $ConfirmLeave
@onready var scenario_picker_container = $HorisontalMenuContainer/ScenarioPickerContainer

func clear_selections():
	if scenario_picker_container.is_visible():
		scenario_picker_container.hide()

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

func _on_map_01_pressed():
	map_chosen.emit('map_01')
