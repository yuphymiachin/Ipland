extends Resource
class_name CharacterResource

@export var character_name: String = "CharacterName"
@export var texture: Texture2D
@export var animation_number_of_frames = 5
@export_file('*.dtl') var intro_timeline
@export_file('*.dtl') var dialog_timeline
