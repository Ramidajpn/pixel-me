extends AnimatedSprite2D

func _ready():
	play("default")
	print("Animation started: ", animation, " Frame: ", frame)
