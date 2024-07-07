extends Control


var node_to_button_map = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.add_selection_option_requested.connect(add_selection)
	Global.remove_selection_option_requested.connect(remove_selection)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	print("button pressed")


func _add_button(button_info):
	var scene = preload("res://UI/SelectionOptionButton.tscn")

	var new_button = scene.instantiate()
	new_button.get_node("CenterContainer/Label").text = button_info.text
	new_button.connect("pressed", button_info.callable)

	get_node("Container").add_child(new_button)
	node_to_button_map[button_info.key] = new_button


func add_selection(key, text, callback):
	print("Received add_selection_option_requested, adding button")
	if callback:
		var button_info = {"key": key, "text": text, "callable": callback}
		_add_button(button_info)


func remove_selection(key):
	print("Received add_selection_option_requested, destroying button")
	if key in node_to_button_map:
		node_to_button_map[key].queue_free()
		node_to_button_map.erase(key)
