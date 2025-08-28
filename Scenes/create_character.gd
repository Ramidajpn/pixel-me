# createcharacter.gd
extends Node2D

# --- Node References ---
@onready var http_request = $HTTPRequest
@onready var camera_ui = $CameraUI 
@onready var loading_screen = $UI/LoadingScreen

# --- Main Functions ---
func _ready():
	# เชื่อม Signal จากโหนด HTTPRequest มาที่ฟังก์ชันของเรา
	http_request.request_completed.connect(_on_request_completed)
	
	# ตั้งค่า UI เริ่มต้น
	camera_ui.show()
	loading_screen.hide()

# --- Signal Handlers ---

# ฟังก์ชันนี้จะทำงานเมื่อ "ปุ่มถ่ายรูป" ถูกกด
func _on_capture_button_pressed():
	# ซ่อน UI ถ่ายรูป, แสดงหน้าจอโหลด
	camera_ui.hide()
	loading_screen.show()
	
	print("Sending signal to Python to start capture process...")
	
	# ส่ง Request ไปกระตุ้น Python Server ให้เริ่มทำงาน
	var error = http_request.request("http://127.0.0.1:5000/create_character", [], HTTPClient.METHOD_POST, "")
	
	# จัดการกรณีที่ส่ง Request ไม่สำเร็จ
	if error != OK:
		push_error("HTTP Request failed: " + str(error))
		loading_screen.hide()
		camera_ui.show()

# ฟังก์ชันนี้จะทำงานเมื่อ Python Server ส่งผลลัพธ์กลับมา
func _on_request_completed(_result, response_code, _headers, body):
	# จัดการกรณีที่ Server ตอบกลับมาพร้อม Error
	if response_code != 200:
		push_error("Python Server responded with an error: " + str(response_code))
		loading_screen.hide()
		camera_ui.show()
		return

	print("Received outfit data from Python Server!")
	var json_string = body.get_string_from_utf8()
	var response = JSON.parse_string(json_string)
	
	# ตรวจสอบว่าข้อมูลที่ได้รับมาถูกต้องหรือไม่
	if response:
		# บันทึก "ชุดที่เลือกแล้ว" ลงใน Autoload
		CharacterData.last_outfit = response
		
		# เปลี่ยนไปหน้า 3 (outfitcreator) ทันที
		get_tree().change_scene_to_file("res://scenes/outfitcreator.tscn") # ‼️ แก้ Path ให้ถูกต้อง
	else:
		print("Invalid or empty response from server.")
		loading_screen.hide()
		camera_ui.show()




#
#
#extends Node2D
#
#@onready var webcam_display = $WebcamDisplay
#@onready var character_display = $CharacterDisplay
#@onready var http_request = $HTTPRequest
#@onready var countdown_timer = $CountdownTimer
#@onready var ui = $UI
#@onready var countdown_label = $UI/CountdownLabel
#@onready var loading_screen = $UI/LoadingScreen
#@onready var reveal_screen = $UI/RevealScreen
#
#@onready var body_sprite = $CharacterDisplay/Body
#@onready var hair_sprite = $CharacterDisplay/Hair
#@onready var shirt_sprite = $CharacterDisplay/Shirt
#@onready var pants_skirt_sprite = $CharacterDisplay/PantsSkirt
#
#const ASSET_MAP = {
	#"hair_long_bangs": [
		#"res://asset/Assetv5/longbang-a.png",
		#"res://asset/Assetv5/longbang-b.png"
	#],
	#"hair_short_bangs": [
		#"res://asset/Assetv5/shortbang-a.png",
		#"res://asset/Assetv5/shortbang-b.png"
	#],
	#"hair_short": [
		#"res://asset/Assetv5/short-a.png"
	#],
	#"hair_male": [
		#"res://asset/Assetv5/male-a.png",
		#"res://asset/Assetv5/male-b.png",
		#"res://asset/Assetv5/male-c.png",
		#"res://asset/Assetv5/male-d.png",
		#"res://asset/Assetv5/male-e.png",
		#"res://asset/Assetv5/male-f.png"
	#],
	#"bald": [
	#],
	#"hair_tie_1_bangs": [
		#"res://asset/Assetv5/1tiebang-a.png",
		#"res://asset/Assetv5/1tiebang-b.png"
	#],
	#"hair_tie_1": [
		#"res://asset/Assetv5/1tie-a.png",
		#"res://asset/Assetv5/1tie-b.png"
	#],
	#"hair_tie_2_bangs": [
		#"res://asset/Assetv5/2tiebang-a.png",
		#"res://asset/Assetv5/2tiebang-b.png",
		#"res://asset/Assetv5/2tiebang-c.png",
		#"res://asset/Assetv5/2tiebang-d.png"
	#],
	#"hair_tie_2": [
		#"res://asset/Assetv5/2tie-a.png",
		#"res://asset/Assetv5/2tie-b.png",
		#"res://asset/Assetv5/2tie-c.png"
	#],
	#"shirt_short": [
		#"res://asset/Assetv5/shortshirt-a.png"
	#],
	#"shirt_long": [
		#"res://asset/Assetv5/longshirt-a.png",
		#"res://asset/Assetv5/longshirt-b.png"
	#],
	#"pants_short": [
		#"res://asset/Assetv5/pantshort-a.png",
		#"res://asset/Assetv5/pantshort-b.png"
	#],
	#"pants_long": [
		#"res://asset/Assetv5/pantlong-a.png",
		#"res://asset/Assetv5/pantlong-b.png"
	#],
	#"skirt_short": [
		#"res://asset/Assetv5/skirtshort-a.png",
		#"res://asset/Assetv5/skirtshort-b.png"
	#],
	#"skirt_long": [
		#"res://asset/Assetv5/skirtlong-a.png"
	#]
#}
#
#var countdown_value = 3
#
#func _ready():
#
	#randomize()
	#http_request.request_completed.connect(_on_request_completed)
	#reset_to_capture_state()
#
#
#func _on_countdown_timer_timeout():
	#countdown_value -= 1
	#if countdown_value > 0:
		#countdown_label.text = str(countdown_value)
	#elif countdown_value == 0:
		#countdown_label.text = "Smile!"
	#else:
		#countdown_timer.stop()
		#countdown_label.hide()
		#_capture_image_and_send()
#
#func _start_countdown():
	#countdown_value = 3
	#countdown_label.text = str(countdown_value)
	#countdown_label.show()
	#countdown_timer.start()
#
#func _capture_image_and_send():
	#print("Capturing image...")
	#webcam_display.hide()
	#loading_screen.show()
	#
	#await get_tree().create_timer(0.1).timeout
	#var img = webcam_display.get_video_texture().get_image()
	#
	#if img.is_empty():
		#push_error("Could not get image from webcam.")
		#return
	#
	#var image_data = img.save_jpg_to_buffer()
	#var base64_string = Marshalls.raw_to_base64(image_data)
	#var body = JSON.stringify({"image": base64_string})
	#var headers = ["Content-Type: application/json"]
	#
	#print("Sending image to Python Server...")
	#var error = http_request.request("http://127.0.0.1:5000/analyze", headers, HTTPClient.METHOD_POST, body)
	#if error != OK:
		#push_error("HTTP Request failed with error: " + str(error))
#
#func _on_request_completed(_result, response_code, _headers, body):
	#loading_screen.hide()
	#if response_code != 200:
		#push_error("Python Server responded with error code: " + str(response_code))
		#return
#
	#print("Received data from Python Server!")
	#var json_string = body.get_string_from_utf8()
	#var response = JSON.parse_string(json_string)
	#
	#if response and response.has("detections"):
		#var detections = response["detections"]
		#_assemble_character(detections)
		#character_display.show()
		#reveal_screen.show()
	#else:
		#print("Invalid response from server.")
#
#
#func _assemble_character(detections: Array):
	#print("Assembling character with detections: ", detections)
	## รีเซ็ต Texture ของ Sprite ต่างๆ ก่อน
	#hair_sprite.texture = null
	#shirt_sprite.texture = null
	#pants_skirt_sprite.texture = null
	#
	#for class_name in detections:
		#if ASSET_MAP.has(class_name):
			#var path_options: Array = ASSET_MAP[class_name]
			#if not path_options.is_empty():
				#var random_texture_path = path_options.pick_random()
				#if "hair" in class_name or "bald" in class_name:
					#hair_sprite.texture = load(random_texture_path)
				#elif "shirt" in class_name:
					#shirt_sprite.texture = load(random_texture_path)
				#elif "pants" in class_name or "skirt" in class_name:
					#pants_skirt_sprite.texture = load(random_texture_path)
				#
			#
#
#func reset_to_capture_state():
	#character_display.hide()
	#loading_screen.hide()
	#reveal_screen.hide()
	#webcam_display.show()
	#_start_countdown()
#
#func _on_dress_up_button_pressed():
	#get_tree().change_scene_to_file("res://scenes/outfitcreator.tscn")
#
#func _on_renew_button_pressed():
	#reset_to_capture_state()
