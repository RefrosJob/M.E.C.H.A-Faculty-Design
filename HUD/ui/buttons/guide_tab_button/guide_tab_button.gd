class_name GuideButton
extends Button

signal guide_button_press

func _on_pressed():
	guide_button_press.emit(self.text)
