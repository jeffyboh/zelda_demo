extends KinematicBody2D

const SPEED = 70

var moveDir = Vector2(0,0)
var spriteDir = "down"

func _physics_process(delta):
	controls_loop()
	movement_loop()
	spriteDir_loop()
	
	if is_on_wall():
		if spriteDir == "Left" and test_move(transform, Vector2(-1,0)):
			anim_switch("push")
		if spriteDir == "Right" and test_move(transform, Vector2(1,0)):
			anim_switch("push")
		if spriteDir == "Up" and test_move(transform, Vector2(0,-1)):
			anim_switch("push")
		if spriteDir == "Down" and test_move(transform, Vector2(0,1)):
			anim_switch("push")
	elif moveDir != Vector2(0,0):
		anim_switch("walk")
	else:
		anim_switch("idle")

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
		Vector2(-1,0):
			spriteDir = "Left"
		Vector2(1,0):
			spriteDir = "Right"
		Vector2(0,-1):
			spriteDir = "Up"
		Vector2(0,1):
			spriteDir = "Down"
			
func anim_switch(animation):
	var newAnim = str(animation, spriteDir)
	
	if $Anim.current_animation != newAnim:
		$Anim.play(newAnim)
