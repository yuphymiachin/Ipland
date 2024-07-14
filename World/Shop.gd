extends StaticBody2D

func _on_area_2d_body_entered(body):
	print("Player entered shop area")
	Global.add_selection_option_requested.emit(self, "Enter", handle_button_click)

func _on_area_2d_body_exited(body):
	print("Player exited shop area")
	#Global.remove_selection_option_requested.emit(self)

func handle_button_click():
	print("Button clicked, sending remove_selection_option_requested event")
	Global.remove_selection_option_requested.emit(self)
	get_tree().change_scene_to_packed(preload("res://World/ShopInterior.tscn"))
