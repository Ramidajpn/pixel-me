extends TextureButton


func _on_title_button_pressed():
	# โหลด Scene หน้า Title
	var title_scene = load("res://Scenes/title.tscn") 
	# เปลี่ยนไป Scene ที่โหลด
	get_tree().change_scene_to_packed(title_scene)
