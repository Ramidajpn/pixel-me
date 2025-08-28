extends TextureRect


# IP และ Port ของ Webcam4Godot
const SERVER_IP = "127.0.0.1"
const SERVER_PORT = 13000

var tcp_client := StreamPeerTCP.new()
var webcam_texture := ImageTexture.new()
var img := Image.new()
var buffer := PoolByteArray()

onready var display = get_node("WebcamDisplay") as TextureRect

func _ready():
	connect_to_server()

func connect_to_server():
	var err = tcp_client.connect_to_host(SERVER_IP, SERVER_PORT)
	if err != OK:
		print("❌ Connection failed: ", err)
		return
	print("✅ Connected to Webcam4Godot!")
	set_process(true)

func _process(delta):
	if tcp_client.get_available_bytes() > 0:
		# อ่านข้อมูลจาก TCP
		buffer = tcp_client.get_data(tcp_client.get_available_bytes())
		if buffer.size() == 0:
			return
		# แปลงเป็น Image (สมมติว่า Webcam4Godot ส่ง raw RGB24)
		img.create_from_data(640, 480, false, Image.FORMAT_RGB8, buffer)
		webcam_texture.create_from_image(img)
		display.texture = webcam_texture
