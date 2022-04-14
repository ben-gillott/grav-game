extends Area2D

const value = 2

func _on_Coin_body_entered(body):
	print("Coin touched")
	Events.emit_signal("score_changed", value)
	pass # Replace with function body.
