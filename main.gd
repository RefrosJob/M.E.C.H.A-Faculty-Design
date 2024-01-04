extends Node

func _on_main_menu_map_chosen(map_name: String):
	$MainMenu.hide()
#	$GameRenderer.set_map(map_name)
	$GameRenderer.toggle_visibility()
	$GameRenderer.instantiate_map_by_name(map_name)
