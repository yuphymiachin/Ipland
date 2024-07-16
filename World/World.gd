extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $YSort/Player

# Called when the node enters the scene tree for the first time.
func _ready():
	var style: DialogicStyle = load("res://Characters/DialogueStyle.tres")
	style.prepare()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_player(position: Vector2):
	player.global_position = position
	camera.position_smoothing_enabled = false
	await get_tree().tree_changed
	camera.position_smoothing_enabled = true


func to_dict() -> Dictionary:
	var invisible_collectable_items := []
	for node in get_tree().get_nodes_in_group("collectable_items"):
		if not node.visible:
			var path := get_path_to(node)
			invisible_collectable_items.append(path)
	
	return {
		"invisible_collectable_items": invisible_collectable_items
	}


func from_dict(dict: Dictionary) -> void:
	print("from_dict called")

	for node in get_tree().get_nodes_in_group("collectable_items"):
		var path := get_path_to(node)
		if path in dict["invisible_collectable_items"]:
			node.deactivate()
