extends KinematicBody2D

const SPEED = 0

var moveDir = Vector2(0,0)
var spriteDir = "down"

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	moveDir.x = -int(LEFT) + int(RIGHT)
	moveDir.y = -int(UP) + int(DOWN)
	
func movement_loop():
	var motion = moveDir.normalized() * SPEED
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