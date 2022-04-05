extends KinematicBody2D

export (int) var speed = 20

const GRAVITY = 200 #in px
var velocity = Vector2.ZERO
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
	#TODO: Check Grounded -> Can jump
	direction = inputDirection
	
func _physics_process(delta):
	#only allows velocity in one cardinal direction at a time 
	if velocity.normalized() != direction:
		#velocity = Vector2.ZERO #stop moving
		velocity = direction * speed
	
	print(str(velocity))
		
	velocity += direction * GRAVITY * delta
	velocity = move_and_slide(velocity)
