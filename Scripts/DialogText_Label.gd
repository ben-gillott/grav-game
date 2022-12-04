# DialogText_Label.gd
extends RichTextLabel

var pg = 0;

signal line_complete()

func player_dialogue_input():
	if (!is_line_complete()):
		show_full_text();
	else:
		emit_signal("line_complete")

func show_full_text():
	set_visible_characters(get_total_character_count());

func is_line_complete():
	return get_visible_characters() > get_total_character_count();

func start_dialog(dialog_text):
	set_bbcode(dialog_text);
	set_visible_characters(0);

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1);

func _on_YarnStory_dialogue(_yarn_node, _actor, message):
	start_dialog(message)

func _on_YarnStory_command(_yarn_node, command, parameters):
	print(command, parameters)
