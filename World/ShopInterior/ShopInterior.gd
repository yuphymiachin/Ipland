extends StaticBody2D

@onready var camera: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player

func _ready():
	pass # Replace with function body.


func _process(delta):
	get_node("AppleNumber").text = "x" + str(Global.get_inventory(Global.Item.APPLE))
	get_node("FirewoodNumber").text = "x" + str(Global.get_inventory(Global.Item.FIREWOOD))
	get_node("CoconutNumber").text = "x" + str(Global.get_inventory(Global.Item.COCONUT))
	get_node("CoffeeBeanNumber").text = "x" + str(Global.get_inventory(Global.Item.COFFEE_BEAN))


func update_player(position: Vector2):
	player.global_position = position
	camera.position_smoothing_enabled = false
	await get_tree().tree_changed
	camera.position_smoothing_enabled = true


func to_dict() -> Dictionary:
	return {}


func from_dict(dict: Dictionary) -> void:
	pass
