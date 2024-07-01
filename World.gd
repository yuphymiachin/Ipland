extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var style: DialogicStyle = load("res://Characters/Style.tres")
	style.prepare()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
