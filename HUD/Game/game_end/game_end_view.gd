class_name GameEndView
extends MarginContainer

@onready var game_result: Label = $GameEndMarginContainer/GameEndContainer/GameResult
@onready var game_result_reason: Label = $GameEndMarginContainer/GameEndContainer/GameResultReason
@onready var time_value: Label = $GameEndMarginContainer/GameEndContainer/TimeContainer/TimeValue

var result: String = 'Unknown'
var reason: String = 'Unknown'
var time: String = 'Unknown'

signal on_back_to_menu_pressed
signal on_retry_pressed


func set_text_data(result: String, reason: String, time: String) -> void:
	result = result
	reason = reason
	time = time + ' Seconds'
	game_result.text = result
	game_result_reason.text = reason
	time_value.text = time
	
func _unpause() -> void:
	if get_tree().paused:
		get_tree().paused = false

func _on_back_to_menu_pressed() -> void:
	on_back_to_menu_pressed.emit()
	self.hide()

func _on_back_to_menu_focus_entered() -> void:
	_unpause()

func _on_retry_pressed() -> void:
	on_retry_pressed.emit()
	self.hide()

func _on_retry_focus_entered() -> void:
	_unpause()
