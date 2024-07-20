extends Node2D

var first_time = true

@export var character_name: String = "CharacterName"
@export var texture: Texture2D
@export var animation_number_of_frames = 5
@export_file('*.dtl') var intro_timeline
@export_file('*.dtl') var dialog_timeline

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = texture
	Dialogic.preload_timeline(intro_timeline)
	Dialogic.preload_timeline(dialog_timeline)
	
	animation_player.play("Idle_" + str(animation_number_of_frames) + "_frames")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interactable_body_entered(body):
	Global.add_selection_option_requested.emit(self, character_name, handle_button_click)
	print("Detected player")

func handle_button_click():	
	if Dialogic.current_timeline != null:
		return
	
	Global.remove_selection_option_requested.emit(self)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	
	if first_time:
		Dialogic.start(intro_timeline)
		first_time = false
	else:
		Dialogic.start(dialog_timeline)
		


func _on_interactable_body_exited(body):
	if Dialogic.timeline_ended.is_connected(_on_timeline_ended):
		Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	Dialogic.end_timeline()
	Global.remove_selection_option_requested.emit(self)


func _on_timeline_ended():
	if Dialogic.timeline_ended.is_connected(_on_timeline_ended):
		Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	await get_tree().process_frame
	Global.add_selection_option_requested.emit(self, character_name, handle_button_click)
