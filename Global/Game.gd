extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_scene(path: String, entry_point: String) -> void:
	get_tree().change_scene_to_file(path)
	await get_tree().tree_changed
	
	for node in get_tree().get_nodes_in_group("entry_points"):
		if node.name == entry_point:
			print("Found entry point with name " + node.name)
			get_tree().current_scene.update_player(node.global_position)
			break


