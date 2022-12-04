extends InteractionManager

onready var yarnstory = get_node("/root/Node2D/DialogBox/YarnStory")

func receive_interaction() -> void:
	yarnstory.step_through_story()
