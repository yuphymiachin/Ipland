extends Node

var world_state := {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_scene(path: String, entry_point: String) -> void:
	var old_name := get_tree().current_scene.scene_file_path.get_file().get_basename()
	world_state[old_name] = get_tree().current_scene.to_dict()
	
	get_tree().change_scene_to_file(path)
	await get_tree().tree_changed
	
	var new_name := get_tree().current_scene.scene_file_path.get_file().get_basename()
	if new_name in world_state:
		get_tree().current_scene.from_dict(world_state[new_name])
	
	for node in get_tree().get_nodes_in_group("entry_points"):
		if node.name == entry_point:
			print("Found entry point with name " + node.name)
			get_tree().current_scene.update_player(node.global_position)
			break


