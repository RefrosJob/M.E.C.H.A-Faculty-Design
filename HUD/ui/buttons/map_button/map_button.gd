class_name MapButton
extends Button

signal map_button_press

func _on_pressed():
	map_button_press.emit(self.text)
