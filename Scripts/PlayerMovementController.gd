extends KinematicBody2D

export (int) var speed = 20

onready var tilemap = get_node("../TileMap")

const GRAVITY = 18 #in px
var velocity = Vector2.ZERO
var direction = Vector2(0,1)
var grounded = true

var just_hit_ground = false;

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
	elif event.is_action_pressed("ui_accept"):
#		print("Interact pressed")
		$InteractionManager.initiate_interaction()

func movePlayer(inputDirection):
	if grounded:
		direction = inputDirection
	
func _physics_process(delta):
	
	#only allows velocity in one cardinal direction at a time 
	if velocity.normalized() != direction:
		velocity = direction * speed
		
	velocity += direction * GRAVITY
	
	velocity = move_and_slide(velocity)
	
	grounded = $Groundcheck.overlaps_body(tilemap)
	
func squashAndStretch():
	var moving = direction.length() > 0
	
	if moving:
		just_hit_ground = false
		#Stretch in falling direction
#		$Sprite.scale.y = range_lerp(abs(motion.y))
		
	elif not moving and not just_hit_ground:
		just_hit_ground = true
		#Squash cause just hit floor - need last fall direciton tho
	
	#always lerp back towards default value

