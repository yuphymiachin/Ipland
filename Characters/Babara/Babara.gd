extends Node2D

@onready var player = get_node("/root/World/YSort/Player")

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

	var layout = Dialogic.start("res://Characters/Babara/intro.dtl")
	layout.register_character(load("res://Characters/Babara/Babara.dch"), self.get_node("Head"))
	layout.register_character(load("res://Characters/Player.dch"), player.get_node("Head"))


func _on_interactable_body_exited(body):
	Dialogic.end_timeline()
