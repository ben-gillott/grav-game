extends KinematicBody2D

export (int) var speed = 20

onready var tilemap = get_node("../TileMap")

const GRAVITY = 18 #in px
var velocity = Vector2.ZERO
var direction = Vector2(0,1)
var grounded = true


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
		$InteractionManager.initiate_interaction()

	
func movePlayer(inputDirection):
	if grounded && Globals.canMove:
		direction = inputDirection
		$PlayerSFX/takeoff.play()
	
func _physics_process(delta):
	
	#only allows velocity in one cardinal direction at a time 
	if velocity.normalized() != direction:
		velocity = direction * speed
		
	velocity += direction * GRAVITY
	
	velocity = move_and_slide(velocity)
	
	grounded = $Groundcheck.overlaps_body(tilemap)
	
	squashAndStretch(delta)
	
	

const PEAK_VELOCITY = 1000
const DEFAULT_SCALE = 62
const STRETCH_FACTOR = 1.2
const SQUASH_FACTOR = 1/STRETCH_FACTOR
var just_hit_ground = true;

func squashAndStretch(delta):
	var moving = velocity.length() > 100
	
#	print("Moving = " + String(moving))
	
	if moving: #currently falling
		just_hit_ground = false
		#Stretch in falling direction
		if(abs(direction.x) == 1): #dir on x axis
			stretchX()
		else: #moving on y axis
			stretchY()
	elif not moving and not just_hit_ground:
		just_hit_ground = true
		#Squash cause just hit floor - need last fall direciton tho
		if(abs(direction.x) == 1):
			squashX()
		else:
			squashY()
#	else:
		#always lerp back towards default value
	unstretchAll(delta)



#	print("=========")
#	print(velocity)
#	print("XScale: " + String(xscale));
#	print("YScale: " + String(yscale));

func stretchY():
	#Value, (range start, stop), range2 start, stop
	var xscale = range_lerp(abs(velocity.y), 0, PEAK_VELOCITY, DEFAULT_SCALE, DEFAULT_SCALE * SQUASH_FACTOR);
	var yscale = range_lerp(abs(velocity.y), 0, PEAK_VELOCITY, DEFAULT_SCALE, DEFAULT_SCALE * STRETCH_FACTOR);
	
	$Sprite.scale.x = xscale;
	$Sprite.scale.y = yscale;

func stretchX():
	var xscale = range_lerp(abs(velocity.x), 0, PEAK_VELOCITY, DEFAULT_SCALE, DEFAULT_SCALE * STRETCH_FACTOR);
	var yscale = range_lerp(abs(velocity.x), 0, PEAK_VELOCITY, DEFAULT_SCALE, DEFAULT_SCALE * SQUASH_FACTOR);
	
	$Sprite.scale.x = xscale;
	$Sprite.scale.y = yscale;

func squashY():
	$Sprite.scale.x = DEFAULT_SCALE;
	$Sprite.scale.y = DEFAULT_SCALE * SQUASH_FACTOR;

func squashX():
	$Sprite.scale.x = DEFAULT_SCALE * SQUASH_FACTOR;
	$Sprite.scale.y = DEFAULT_SCALE;

func unstretchAll(delta):
	$Sprite.scale.x = lerp($Sprite.scale.x, DEFAULT_SCALE, 1 - pow(0.00001, delta))
	$Sprite.scale.y = lerp($Sprite.scale.y, DEFAULT_SCALE, 1 - pow(0.00001, delta))
	
	
