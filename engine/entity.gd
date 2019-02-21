extends KinematicBody2D

const TYPE = "ENEMY"
const MAXHEALTH = 2
const SPEED = 0

var movedir = Vector2(0,0)
var knockdir = Vector2(0,0)
var spritedir = "Down"

var hitstun = 0
var health = MAXHEALTH
var texture_default = null
var texture_hurt = null

func _ready():
	texture_default = $Sprite.texture
	texture_hurt = load($Sprite.texture.get_path().replace(".png", "_hurt.png"))

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
		motion = knockdir.normalized() * 125
		
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
		$Sprite.texture = texture_hurt
		if TYPE == "ENEMY" && health <= 0:
			var death_animation = preload("res://enemies/enemy_death.tscn").instance()
			get_parent().add_child(death_animation)
			death_animation.global_transform = global_transform
			queue_free()
	else:
		$Sprite.texture = texture_default
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