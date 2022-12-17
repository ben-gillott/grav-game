extends Area2D

class_name InteractionManager

var current_interaction: InteractionManager

export var npcName = "NPC Name"

func initiate_interaction() -> void:
	if current_interaction != null:
		current_interaction.receive_interaction() 
	else:
		print("No current interaction")

func receive_interaction() -> void:
	start_dialog(npcName)

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
		var dialog = Dialogic.start(timeline)
		get_parent().add_child(dialog)
		dialog.pause_mode = PAUSE_MODE_PROCESS
		dialog.connect("timeline_end", self, "end_dialog")
		get_tree().paused = true
		
func end_dialog():
	print("Ending timeline")
	get_tree().paused = false
