extends Node

const SAVE_PATH := "user://dava.sav"

var world_state := {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_scene(path: String, params := {}, save_state := true) -> void:
	if save_state:
		var old_name := get_tree().current_scene.scene_file_path.get_file().get_basename()
		world_state[old_name] = get_tree().current_scene.to_dict()
	
	get_tree().change_scene_to_file(path)
	await get_tree().tree_changed

	call_deferred("_resume_scene_change", params)

func _resume_scene_change(params := {}):
	var new_scene = get_tree().current_scene
	if !is_instance_valid(new_scene):
		print("New scene is not valid after change.")
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


func save_game() -> void:
	print("Saving game to data.sav")
	var scene := get_tree().current_scene
	var scene_name := scene.scene_file_path.get_file().get_basename()
	world_state[scene_name] = scene.to_dict()
	
	var data := {
		"world_state": world_state,
		"scene": scene.scene_file_path,
		"player": {
			"position": {
				"x": scene.player.global_position.x,
				"y": scene.player.global_position.y
			}
		}
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
		return
	var json:= file.get_as_text()
	var data := JSON.parse_string(json) as Dictionary
	
	world_state = data.world_state
	
	change_scene(data.scene, {"position": Vector2(data.player.position.x, data.player.position.y)}, false)
	

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		load_game()


