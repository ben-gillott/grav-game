extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("at menu")
	var button = $StartButton
	
	button.connect("pressed", self, "_button_pressed")

func _button_pressed():
	print("Start Button Pressed")
	get_tree().change_scene("res://Scenes/PlayScene.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
