extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.preload_timeline("res://Characters/Babara/intro.dtl")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interactable_body_entered(body):
	print("Detected player")
	
	if Dialogic.current_timeline != null:
		return

	Dialogic.start("res://Characters/Babara/intro.dtl")


func _on_interactable_body_exited(body):
	Dialogic.end_timeline()
