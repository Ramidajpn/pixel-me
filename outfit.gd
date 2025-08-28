# outfitcreator.gd (เวอร์ชันหุ่นเชิด)
extends Node2D

@onready var hair_sprite = $CharacterDisplay/hair
@onready var shirt_sprite = $CharacterDisplay/shirt
@onready var pants_skirt_sprite = $CharacterDisplay/PantsSkirt

func _ready():
	# อ่านข้อมูล "ชุดที่เลือกแล้ว" จาก Autoload
	var outfit_data = CharacterData.last_outfit
	
	if not outfit_data.is_empty():
		_assemble_character(outfit_data)
	else:
		print("No outfit data found.")

# ‼️‼️ ฟังก์ชันประกอบร่างที่ง่ายที่สุด ‼️‼️
func _assemble_character(data: Dictionary):
	print("Assembling character with final outfit: ", data)
	
	hair_sprite.texture = null
	shirt_sprite.texture = null
	pants_skirt_sprite.texture = null
	
	# Godot แค่รอรับคำสั่งว่าจะให้โหลดรูปอะไร
	if data.has("hair"):
		hair_sprite.texture = load(data.hair)
	
	if data.has("shirt"):
		shirt_sprite.texture = load(data.shirt)
		
	if data.has("pants_skirt"):
		pants_skirt_sprite.texture = load(data.pants_skirt)
