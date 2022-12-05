extends CanvasLayer

var commands = {}

var block_progress = false

var inDialogue = false


func _init():
	commands['close_dialogue'] = funcref(self, "close_dialogue")
	commands['vted'] = funcref(self, "vted")

	
func _on_YarnStory_dialogue(yarn_node, actor, message):
	if (!$Dialog_Control.visible):
		$Dialog_Control.visible = true
	inDialogue = true

func _on_DialogText_Label_line_complete():
	if (!block_progress):
		$YarnStory.step_through_story()

func _on_YarnStory_options(yarn_node, options):
	block_progress = true

func _on_select_option(option):
	block_progress = false
	$YarnStory.step_through_story(option)

func _on_YarnStory_command(yarn_node, command, parameters):
	if (commands.has(command)):
		commands[command].call_funcv(parameters)

func close_dialogue():
	$Dialog_Control.visible = false
	inDialogue = false
	
func vted(nodeName):
	print(nodeName)
