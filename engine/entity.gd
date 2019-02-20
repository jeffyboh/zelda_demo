extends KinematicBody2D

const TYPE = "ENEMY"
const SPEED = 0

var movedir = Vector2(0,0)
var knockdir = Vector2(0,0)
var spritedir = "Down"

var hitstun = 0
var health = 1

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	
func movement_loop():
	var motion
	
	if hitstun == 0:
		motion = movedir.normalized() * SPEED
	else:
		motion = knockdir.normalized() * SPEED * 1.5
		
	move_and_slide(motion, Vector2(0,0))
	
func spritedir_loop():
	match movedir:
		dir.left:
			spritedir = "Left"
		dir.right:
			spritedir = "Right"
		dir.up:
			spritedir = "Up"
		dir.down:
			spritedir = "Down"

func damage_loop():
	if hitstun > 0:
		hitstun -= 1
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = global_transform.origin - body.global_transform.origin
			
func use_item(item):
	var newitem = item.instance()
	newitem.add_to_group(str(newitem.get_name(), self))
	add_child(newitem)
	if get_tree().get_nodes_in_group(str(newitem.get_name(), self)).size() > newitem.maxamount:
		newitem.queue_free()