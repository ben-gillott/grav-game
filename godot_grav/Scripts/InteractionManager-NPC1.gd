extends InteractionManager

onready var count = 0

func receive_interaction() -> void:
	match count:
		0:
			print("Greetings traveller")
		1:
			print("I guess you're on your way out")
		2:
			print("Make sure to say your farewells")
		3:
			print("Good luck!")
	
	count += 1
