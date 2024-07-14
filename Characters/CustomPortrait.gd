extends DialogicPortrait

func _get_covered_rect() -> Rect2:
	return Rect2($Sprite2D.position, $Sprite2D.get_rect().size)
