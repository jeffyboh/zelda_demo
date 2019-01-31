extends "res://engine/entity.gd"

const TYPE = "PLAYER"
const SPEED = 70

func _physics_process(delta):
	controls_loop()
	movement_loop()
	spriteDir_loop()
	damage_loop()
	
	if is_on_wall():
		if spriteDir == "Left" and test_move(transform, dir.left):
			anim_switch("push")
		if spriteDir == "Right" and test_move(transform, dir.right):
			anim_switch("push")
		if spriteDir == "Up" and test_move(transform, dir.up):
			anim_switch("push")
		if spriteDir == "Down" and test_move(transform, dir.down):
			anim_switch("push")
	elif moveDir != Vector2(0,0):
		anim_switch("walk")
	else:
		anim_switch("idle")

func anim_switch(animation):
	var newAnim = str(animation, spriteDir)
	
	if $Anim.current_animation != newAnim:
		$Anim.play(newAnim)
