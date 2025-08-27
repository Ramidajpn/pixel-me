extends TextureButton

func _on_button_pressed():
	# โหลด Scene หลัก (game.tscn)
	# แก้ไข path ให้ถูกต้อง
	var game_scene = load("res://Scenes/game.tscn") 
	get_tree().change_scene_to_packed(game_scene)
