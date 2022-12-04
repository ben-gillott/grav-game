extends Area2D

class_name InteractionManager

var current_interaction: InteractionManager

func initiate_interaction() -> void:
	if current_interaction != null:
		#Whoever currently interacting with, on interact, trigger dialogue etc
		print("Interacted")
		current_interaction.receive_interaction() 
	else:
		print("No current interaction")

func receive_interaction() -> void:
	print("No interaction receptions behavior defined")

func _on_InteractionManager_area_entered(area):
	#TODO: Check if closer than current interaction
	current_interaction = area

func _on_InteractionManager_area_exited(area):
	#If leave the area of current interaction, set current to null
	if current_interaction == area:
		current_interaction = null
