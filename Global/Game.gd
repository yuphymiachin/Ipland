extends Node

const SAVE_PATH := "user://dava.sav"

var world_state := {}

var is_game_state_loaded = false

var is_world_scene_initialized = false

func _ready():
	load_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_scene(path: String, params := {}, initial := false) -> void:
	print("Changing scene")

	if initial:
		get_tree().call_deferred("change_scene_to_file", path)
	else:
		var old_name := get_tree().current_scene.scene_file_path.get_file().get_basename()
		world_state[old_name] = get_tree().current_scene.to_dict()
		get_tree().change_scene_to_file(path)

	# Wait for the scene to finish loading
	await get_tree().tree_changed
	if initial:
		await get_tree().process_frame
		is_game_state_loaded = true
	
	var new_scene = get_tree().current_scene
	if !is_instance_valid(new_scene):
		print("New scene is not valid after change. Wait for 1 frame")
		await get_tree().process_frame
		new_scene = get_tree().current_scene
		if is_instance_valid(new_scene):
			print("New scene is valid, proceeding")
		else:
			print("New scene is still not valid.")
			return
	
	var new_name: String = new_scene.scene_file_path.get_file().get_basename()
	if new_name in world_state:
		new_scene.from_dict(world_state[new_name])
	
	if "entry_point" in params:
		for node in get_tree().get_nodes_in_group("entry_points"):
			if node.name == params.entry_point:
				print("Found entry point with name " + node.name)
				new_scene.update_player(node.global_position)
				break
	elif "position" in params:
		new_scene.update_player(params.position)
	
	Game.save_game()


func save_game() -> void:
	print("Saving game to data.sav")
	var scene := get_tree().current_scene
	var scene_name := scene.scene_file_path.get_file().get_basename()
	world_state[scene_name] = scene.to_dict()
	
	var data := {
		"world_state": world_state,
		"last_scene": scene.scene_file_path,
		"player": {
			"position": {
				"x": scene.player.global_position.x,
				"y": scene.player.global_position.y
			}
		},
		"inventory": Global.inventory,
		"time": Time.get_unix_time_from_system()
	}
	var json := JSON.stringify(data)
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if not file:
		return
	file.store_string(json)


func load_game() -> void:
	print("Loading game from data.sav")
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		is_game_state_loaded = true
		Global.update_new_visitor_count()
		return
	var json:= file.get_as_text()
	var data := JSON.parse_string(json) as Dictionary
	
	world_state = data.world_state

	var converted_inventory = {}
	# Convert keys to integers and keep the values as they are
	for key in data.inventory.keys():
		converted_inventory[int(key)] = data.inventory[key]
	# Assign the converted inventory to Global.inventory
	Global.inventory = converted_inventory
	
	if _should_spawn_new_visitor(data.time):
		Global.update_new_visitor_count()
	
	#change_scene(data.scene, {"position": Vector2(data.player.position.x, data.player.position.y)}, false)
	change_scene("res://World/World.tscn", {"entry_point": "EntryPoint"}, true)

func _should_spawn_new_visitor(last_game_time):
	var difference_in_seconds = abs(Time.get_unix_time_from_system() - last_game_time)

	print(difference_in_seconds)
	if difference_in_seconds >= 3600:
		print("The timestamps are greater than 1 hour")
		return true
	else:
		print("The timestamps are not 1 hour apart.")
		return false
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_WM_GO_BACK_REQUEST:
		print("Quitting game")
		save_game()
		get_tree().quit()

