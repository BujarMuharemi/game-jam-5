extends CharacterBody2D 

@export var speed = 350
@export var bullet_scene: PackedScene
@export var bullets = 30
@export var health = 100
@export var gunDistance = 60

var screen_size
var hud
signal bullet_shot
signal player_died
var animation
var walkAnimationFlag = false
var canShootFlag = true

# https://stackoverflow.com/questions/48714224/how-to-see-if-mouse-is-down-or-screen-is-touched-in-event/48722860#48722860

func _ready():
	screen_size = get_viewport_rect().size
	#get_parent().get_node("Player").connect("bullet_shot",update_bullets(bullets-1))
	hud = get_parent().get_node("HUD")
	animation = $AnimationPlayer
	

var A = Vector2(50,50)
var B = Vector2(100, 100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1				
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimationPlayer.play("enemy_walk")
	else:
		$AnimationPlayer.pause()
		
		
	position += velocity * delta
	#print($GunCoolDown.time_left,canShootFlag)
	if($GunCoolDown.is_stopped()):
		canShootFlag = true		
		

	if Input.is_mouse_button_pressed(1) && canShootFlag:  
		var mousePos = get_viewport().get_mouse_position()
		var diff = mousePos - position
		diff =  position.direction_to(mousePos)
		
		var bullet = bullet_scene.instantiate()
		bullet.position = position + diff*gunDistance#(diff.normalized/2) #event.position 
		var angle = bullet.position.angle_to(diff)
		
		bullet.direction = global_position.direction_to(get_global_mouse_position())
		
		get_parent().add_child(bullet)
		#emit_signal("bullet_shot")
		bullets-=1
		hud.update_bullets(bullets)
		
		canShootFlag = false
		$GunCoolDown.start()

#func _draw():	aaa
#	draw_line(A, B, Color(250,1,1), 3)
	
func _input(event):
		
	if event is InputEventMouseMotion:
		#TODO: add this code to when the player is also moving
		var diff = event.position - position
		diff =  position.direction_to(event.position)
		$Gun.position = diff*gunDistance

func _on_area_2d_area_entered(area):
	if(area.is_in_group("enemy")):
		health-=area.damage
		if(health>0):
			hud.update_health(health)
		else:
			hud.update_health(health)
			emit_signal("player_died")
		
