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

func Start() -> void:
	variables["$name"] = "friend"
	emit_signal("dialogue", self, "Linda", "Hello there, \"[color=blue]{$name}[/color]\".".format(variables))
	yield()
	emit_signal("dialogue", self, "Bob", "My name isn't just {$name}... it's".format(variables))
	yield()
	emit_signal("options", self, ["Jim".format(variables), "Bob".format(variables), "Actually it is...".format(variables)])
	match yield():
		"Jim":
			variables["$name"] = "Jim"
			emit_signal("dialogue", self, "Bob", "It's {$name}...".format(variables))
			yield()
			current_function = "theEnd"
			return theEnd()
		"Bob":
			variables["$name"] = "Bob"
			emit_signal("dialogue", self, "Bob", "It's {$name}...".format(variables))
			yield()
			current_function = "theEnd"
			return theEnd()
		"Actually it is...":
			emit_signal("dialogue", self, "Bob", "Oh. No wait. My name IS {$name}...".format(variables))
			yield()
			emit_signal("options", self, ["But. Seriously... don't talk to me.".format(variables), "And hello to you too...".format(variables)])
			match yield():
				"But. Seriously... don't talk to me.":
					current_function = "goodbye"
					return goodbye()
				"And hello to you too...":
					current_function = "hello"
					return hello()

func goodbye() -> void:
	emit_signal("dialogue", self, "Linda", "Aww. Sad.".format(variables))
	yield()
	emit_signal("dialogue", self, "Bob", "oh thank god.".format(variables))
	yield()
	current_function = "theEnd"
	return theEnd()

func hello() -> void:
	emit_signal("dialogue", self, "Linda", "Yay! Hello world.".format(variables))
	yield()
	current_function = "theEnd"
	return theEnd()

func theEnd() -> void:
	emit_signal("command", self, "the_end", [])
	yield()
