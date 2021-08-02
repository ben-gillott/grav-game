extends KinematicBody2D

export (int) var speed = 200

const GRAVITY = 10 #in px
var velocity = Vector2()

var direction = Vector2.ZERO
	
func _input(event):
	#Movement
	if event.is_action_pressed("ui_left"):
		movePlayer(Vector2(-1,0))
	elif event.is_action_pressed("ui_right"):
		movePlayer(Vector2(1,0))
	elif event.is_action_pressed("ui_up"):
		movePlayer(Vector2(0,-1))
	elif event.is_action_pressed("ui_down"):
		movePlayer(Vector2(0,1))
		
	#Interaction
	if event.is_action_pressed("ui_accept"):
		pass #TODO: Interact

func movePlayer(inputDirection):
	#Grounded -> Can jump
	
	direction = inputDirection
	
func _physics_process(delta):
	
	#TODO: rethink this
	#only allows velocity in one cardinal direction at a time 
	if velocity.normalized() != direction:
		velocity = Vector2.ZERO
	
	print(str(velocity))
		
	velocity += direction * GRAVITY
	velocity = move_and_slide(velocity)
