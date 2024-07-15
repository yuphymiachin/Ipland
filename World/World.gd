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
