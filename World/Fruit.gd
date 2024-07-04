extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if not visible:
		deactivate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print("Body entered, sending add_selection_option_requested event")
	Global.add_selection_option_requested.emit(self, get_meta("display_name"), handle_button_click)


func _on_body_exited(body):
	print("Body exited, sending remove_selection_option_requested event")
	Global.remove_selection_option_requested.emit(self)


func handle_button_click():
	print("Button clicked, setting visible to false, sending remove_selection_option_requested event")
	deactivate()
	Global.remove_selection_option_requested.emit(self)

func deactivate():
	hide()
	set_process(false)
	set_physics_process(false)
	set_process_unhandled_input(false)
	set_process_input(false)
	get_node("CollisionShape2D").disabled = true
	
func activate():
	show()
	set_process(true)
	set_physics_process(true)
	set_process_unhandled_input(true)
	set_process_input(true)
	get_node("CollisionShape2D").disabled = false
