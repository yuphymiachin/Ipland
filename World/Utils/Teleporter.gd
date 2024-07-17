extends Area2D

@export_file("*.tscn") var path: String
@export var entry_point: String
@export var auto_teleport: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_entered(player: Player):
	print("Player entered Teleporter")
	if auto_teleport:
		call_deferred("change_scene", path, entry_point)
	else:
		Global.add_selection_option_requested.emit(self, "Enter Shop", handle_button_click)


func _on_player_exited(player: Player):
	print("Player exited Teleporter")
	if not auto_teleport:
		Global.remove_selection_option_requested.emit(self)


func handle_button_click():
	print("Button clicked, sending remove_selection_option_requested event")
	Global.remove_selection_option_requested.emit(self)
	change_scene(path, entry_point)


func change_scene(path, entry_point):
	Game.change_scene(path, entry_point)
