# CharacterData.gd
extends Node

# Dictionary สำหรับเก็บ Path ของชุดที่ตัวละครใส่อยู่
# Python Server จะเป็นคนส่งข้อมูลมาใส่ในนี้
var last_outfit: Dictionary = {}

# (ฟังก์ชันเสริม) ใช้สำหรับรีเซ็ตข้อมูลเมื่อต้องการ
func reset_data():
	last_outfit = {}
