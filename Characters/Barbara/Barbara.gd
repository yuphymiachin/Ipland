extends Node2D

var first_time = true


# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.preload_timeline("res://Characters/Barbara/BarbaraIntro.dtl")
	Dialogic.preload_timeline("res://Characters/Barbara/BarbaraDialog.dtl")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interactable_body_entered(body):
	Global.add_selection_option_requested.emit(self, "Barbara", handle_button_click)
	print("Detected player")

func handle_button_click():	
	if Dialogic.current_timeline != null:
		return
		
	if !first_time:
		Dialogic.start("res://Characters/Barbara/BarbaraDialog.dtl")
		first_time = false
	else:
		Dialogic.start("res://Characters/Barbara/BarbaraIntro.dtl")
		


func _on_interactable_body_exited(body):
	Dialogic.end_timeline()
	Global.remove_selection_option_requested.emit(self)
