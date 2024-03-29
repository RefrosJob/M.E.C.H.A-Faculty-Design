extends HTTPRequest

signal new_command_signal

func ready():
	use_threads = true

func _on_logic_timer_timeout():
	## ADD PROPER ERROR HANDLING
	cancel_request()
	request('http://127.0.0.1:6060/game', ["Content-Type: application/json"], HTTPClient.METHOD_POST, JSON.stringify($WorldData.get_full_info()))

func _on_request_completed(_result, response_code, _headers, body):
	if response_code != 200:
		print('error: ', response_code)
		print(JSON.parse_string(body.get_string_from_utf8()))
		return
	var commands =JSON.parse_string(body.get_string_from_utf8())
	for command in commands:
		if command is Array:
			new_command_signal.emit(command)
	

func set_navmesh(_navmesh):
	if $WorldData:
		$WorldData.set_navmesh(_navmesh)
		$CommandTranslation.set_navmesh(_navmesh)
	
