extends InteractionManager

#onready var yarnstory = get_node("/root/Node2D/DialogBox/YarnStory")

func receive_interaction() -> void:
#	yarnstory.set_current_yarn_thread("bob_start")
#	yarnstory.step_through_story()
	print("NPC interacted")
