extends Area2D

signal goto_condition_met

func _goto_condition_met():
	goto_condition_met.emit()


func _on_body_entered(body):
	if body && body.get_is_player_controlled():
		print('ENTERED')
		goto_condition_met.emit()
