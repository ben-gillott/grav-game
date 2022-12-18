extends Area2D

class_name InteractionManager

var current_interaction: InteractionManager

func initiate_interaction() -> void:
	if current_interaction != null:
		current_interaction.receive_interaction() 
	else:
		print("No current interaction")

func receive_interaction() -> void:
	start_dialog(get_parent().timelineName)

func _on_InteractionManager_area_entered(area):
	#TODO: Check if closer than current interaction
	current_interaction = area

func _on_InteractionManager_area_exited(area):
	#If leave the area of current interaction, set current to null
	if current_interaction == area:
		current_interaction = null


func start_dialog(timeline):
	if !Globals.inDialog:
		Globals.inDialog = true
		Globals.canMove = false
		var dialog = Dialogic.start(timeline)
		get_parent().add_child(dialog)
		dialog.connect("timeline_end", self, "end_dialog")

func end_dialog(timeline):
	print("Ending timeline ", timeline)
	Globals.canMove = true
	yield(get_tree().create_timer(1.5), "timeout")
	Globals.inDialog = false
