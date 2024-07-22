extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $YSort/Player

var character_pool = [
	preload("res://Characters/Resources/Barbara.tres"),
	preload("res://Characters/Resources/Apple.tres"),
	preload("res://Characters/Resources/Rick.tres")
]

var character_scene = preload("res://Characters/CharacterPixel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var style: DialogicStyle = load("res://Characters/DialogueStyle.tres")
	style.prepare()
	
	generate_characters()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func generate_characters():
	var number_of_visitors = Global.get_new_visitor_count()
	
	var spawn_positions = get_tree().get_nodes_in_group("character_markers")
	
	# Shuffle the spawn positions to pick random ones
	spawn_positions.shuffle()
	
	# Create a copy of the character pool to avoid modifying the original
	var available_characters = character_pool.duplicate()
	
	for i in range(min(number_of_visitors, spawn_positions.size(), available_characters.size())):
		var spawn_position = spawn_positions[i]
		var character_instance = character_scene.instantiate()
		
		# Pick a random character from the available characters
		var random_index = randi() % available_characters.size()
		var character_resource = available_characters[random_index]
		
		# Remove the chosen character from the available list to avoid duplicates
		available_characters.remove_at(random_index)
		
		character_instance.character_resource = character_resource
		
		# Set the character's position relative to the spawn position
		character_instance.position = Vector2.ZERO
		
		# Add the character as a child of the spawn position
		spawn_position.add_child(character_instance)
		
		# Tell global script that one character has been added
		Global.report_new_visitors(1)


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
	
	var spawned_characters := []
	for spawn_point in get_tree().get_nodes_in_group("character_markers"):
		for character in spawn_point.get_children():
			spawned_characters.append({
				"spawn_point": get_path_to(spawn_point),
				"character_resource": character.character_resource.resource_path,
				"relative_position": character.position
			})
	
	return {
		"invisible_collectable_items": invisible_collectable_items,
		"spawned_characters": spawned_characters
	}


func from_dict(dict: Dictionary) -> void:
	# Handle invisible collectable items
	for node in get_tree().get_nodes_in_group("collectable_items"):
		var path := get_path_to(node)
		if path in dict["invisible_collectable_items"]:
			node.deactivate()
	
	# Spawn characters
	for character_data in dict["spawned_characters"]:
		var spawn_point = get_node(character_data["spawn_point"])
		var character_instance = character_scene.instantiate()
		
		character_instance.character_resource = load(character_data["character_resource"])
		character_instance.position = character_data["relative_position"]
		
		spawn_point.add_child(character_instance)
