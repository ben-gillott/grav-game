extends Node

signal dialogue(yarn_node, actor, message)
signal command(yarn_node, command, parameters)
signal options(yarn_node, options)

var story_state = null
var current_function := "Start"
var variables := {}

func set_current_yarn_thread(thread_name: String) -> void:
	current_function = thread_name
	story_state = null

func set_variable(var_name: String, value) -> void:
	variables["$" + var_name] = value

func get_variable(var_name: String):
	return variables["$" + var_name]

func step_through_story(value = null) -> void:
	if current_function != "":
		if story_state is GDScriptFunctionState:
			story_state = story_state.resume(value)
		else:
			story_state = call(current_function)

func bob_start() -> void:
	if (variables["$visited_bob"]) == null:
		variables["$visited_bob"] = 0
	elif (variables["$visited_bob"]):
		emit_signal("dialogue", self, "Bob", "You have visited me before, player".format(variables))
		yield()
	else:
		emit_signal("dialogue", self, "Bob", "Hail and well met.".format(variables))
		yield()
		variables["$visited_bob"] = 1
	emit_signal("command", self, "close_dialogue", [])
	yield()
