extends TextureButton

func _on_texture_button_pressed():
	# โหลด Scene หลัก (finished.tscn)
	# แก้ไข path ให้ถูกต้อง
	var finished_scene = load("res://Scenes/finished.tscn") 
	get_tree().change_scene_to_packed(finished_scene)
