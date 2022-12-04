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
	variables["$cake"] = "cake h"
	emit_signal("dialogue", self, "Linda", "Why hello there.".format(variables))
	yield()
	emit_signal("dialogue", self, "Linda", "I'd love to have some \"[color=blue]{$cake}[/color]\" with you.".format(variables))
	yield()
	emit_signal("command", self, "set_cake_visible", ["true"])
	yield()
	emit_signal("dialogue", self, "Bob", "That's terrifying...".format(variables))
	yield()
	emit_signal("dialogue", self, "Bob", "Please put that away.".format(variables))
	yield()
	emit_signal("dialogue", self, "Bob", "That's not even {$cake}... it's".format(variables))
	yield()
	emit_signal("options", self, ["Pizza".format(variables), "Taco Salad".format(variables), "Actually it is...".format(variables)])
	match yield():
		"Pizza":
			variables["$cake"] = "pizza"
			emit_signal("dialogue", self, "Bob", "It's {$cake}...".format(variables))
			yield()
			current_function = "theEnd"
			return theEnd()
		"Taco Salad":
			variables["$cake"] = "taco salad"
			emit_signal("dialogue", self, "Bob", "It's {$cake}...".format(variables))
			yield()
			current_function = "theEnd"
			return theEnd()
		"Actually it is...":
			emit_signal("dialogue", self, "Bob", "Oh. No wait. That is {$cake}...".format(variables))
			yield()
			emit_signal("options", self, ["But. Seriously Lin... put the cake away".format(variables), "I guess it's OK then...".format(variables)])
			match yield():
				"But. Seriously Lin... put the cake away":
					current_function = "noCake"
					return noCake()
				"I guess it's OK then...":
					current_function = "yayCake"
					return yayCake()

func noCake() -> void:
	emit_signal("dialogue", self, "Linda", "Aww. You're no fun.".format(variables))
	yield()
	emit_signal("command", self, "set_cake_visible", ["false"])
	yield()
	emit_signal("dialogue", self, "Bob", "oh thank god.".format(variables))
	yield()
	current_function = "theEnd"
	return theEnd()

func yayCake() -> void:
	emit_signal("dialogue", self, "Linda", "Yay! I love {$cake}!".format(variables))
	yield()
	emit_signal("dialogue", self, "Bob", "Yeah, cake is pretty good.".format(variables))
	yield()
	current_function = "theEnd"
	return theEnd()

func theEnd() -> void:
	emit_signal("command", self, "the_end", [])
	yield()
