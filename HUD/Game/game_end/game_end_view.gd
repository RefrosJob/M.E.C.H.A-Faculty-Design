extends MarginContainer

signal on_back_to_menu_pressed

func _on_back_to_menu_pressed():
	on_back_to_menu_pressed.emit()
	self.hide()


func _on_back_to_menu_focus_entered():
	get_tree().paused = false
