extends Node

func _on_main_menu_map_chosen(map_name: String):
	$MainMenu.clear_selections()
	$MainMenu.hide()
	$GameRenderer.toggle_visibility(true)
	$GameRenderer.instantiate_map_by_name(map_name)


func _on_game_renderer_render_stop():
	$MainMenu.show()
