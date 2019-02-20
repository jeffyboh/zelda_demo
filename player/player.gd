extends "res://engine/entity.gd"

const TYPE = "PLAYER"
const SPEED = 70

var state = "default"

func _physics_process(delta):
	match state:
		"default":
			state_default()
		"swing":
			state_swing()
	
func state_default():
	controls_loop()
	movement_loop()
	spritedir_loop()
	damage_loop()
	
	if is_on_wall():
		if spritedir == "Left" and test_move(transform, dir.left):
			anim_switch("push")
		if spritedir == "Right" and test_move(transform, dir.right):
			anim_switch("push")
		if spritedir == "Up" and test_move(transform, dir.up):
			anim_switch("push")
		if spritedir == "Down" and test_move(transform, dir.down):
			anim_switch("push")
	elif movedir != Vector2(0,0):
		anim_switch("walk")
	else:
		anim_switch("idle")
	
	if Input.is_action_just_pressed("a"):
		use_item(preload("res://items/sword.tscn"))

func state_swing():
	anim_switch("idle")
	damage_loop()
	

func anim_switch(animation):
	var newanim = str(animation, spritedir)
	
	if $Anim.current_animation != newanim:
		$Anim.play(newanim)
