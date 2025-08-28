extends TextureButton

func _on_button_pressed():
	# โหลด Scene หลัก (game.tscn)
	# แก้ไข path ให้ถูกต้อง
	var create_character = load("res://Scenes/create_character.tscn") 
	get_tree().change_scene_to_packed(create_character)
