extends KinematicBody2D

const TYPE = "ENEMY"
const SPEED = 0

var moveDir = Vector2(0,0)
var knockDir = Vector2(0,0)
var spriteDir = "down"

var hitstun = 0
var health = 1

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	moveDir.x = -int(LEFT) + int(RIGHT)
	moveDir.y = -int(UP) + int(DOWN)
	
func movement_loop():
	var motion
	
	if hitstun == 0:
		motion = moveDir.normalized() * SPEED
	else:
		motion = knockDir.normalized() * SPEED * 1.5
		
	move_and_slide(motion, Vector2(0,0))
	
func spriteDir_loop():
	match moveDir:
		dir.left:
			spriteDir = "Left"
		dir.right:
			spriteDir = "Right"
		dir.up:
			spriteDir = "Up"
		dir.down:
			spriteDir = "Down"

func damage_loop():
	if hitstun > 0:
		hitstun -= 1
	for body in $hitbox.get_overlapping_bodies():
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockDir = transform.origin - body.transform.origin
			
			