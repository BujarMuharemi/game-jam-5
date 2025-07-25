extends CharacterBody2D 

@export var speed = 350
@export var bullet_scene: PackedScene
@export var bullets = 30
@export var health = 100
@export var gunDistance: int
@export var gunCoolDownTime: float
@export var bulletsSlowdownFactor: float
@export var player_hit_scene: PackedScene 
  

var screen_size 
var hud
signal bullet_shot
signal player_died
var animation
var walkAnimationFlag = false
var canShootFlag = true
var currentSpeed = speed
var windowBorderOffset = 40

# https://stackoverflow.com/questions/48714224/how-to-see-if-mouse-is-down-or-screen-is-touched-in-event/48722860#48722860

func _ready():
	screen_size = get_viewport_rect().size
	#get_parent().get_node("Player").connect("bullet_shot",update_bullets(bullets-1))
	hud = get_parent().get_node("HUD")
	animation = $AnimationPlayer
	$GunCoolDown.wait_time = gunCoolDownTime
	currentSpeed = speed - bullets * bulletsSlowdownFactor
	hud.update_health(health)

var A = Vector2(50,50)
var B = Vector2(100, 100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currentSpeed = speed - bullets*bulletsSlowdownFactor 
	hud.update_speed(currentSpeed)
		
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1				
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	
	
	if velocity.length():
		velocity = velocity.normalized() * currentSpeed
		$AnimationPlayer.play("enemy_walk")
	else:
		$AnimationPlayer.pause()
	
	if(bullets <= 1 && !$LowAmmo.is_playing() && $LowAmmo/Timer.get_time_left()==0):
		$LowAmmo.play()	
		$LowAmmo/Timer.start()
	
		
	var newPos = position + velocity * delta
	if(newPos.x-windowBorderOffset > 0 && newPos.x+windowBorderOffset < 1600):
		if(newPos.y-windowBorderOffset > 0 && newPos.y+windowBorderOffset < 900):
			position += velocity * delta
	#print($GunCoolDown.time_left,canShootFlag)
	if($GunCoolDown.is_stopped()):
		canShootFlag = true		
	

	if Input.is_mouse_button_pressed(1) && canShootFlag && bullets>0: 		
		$GunShot.play()
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
	elif Input.is_mouse_button_pressed(1) && canShootFlag && bullets==0:
		$GunDryFire.play()
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
		$Gun.look_at(get_global_mouse_position())
		if($Gun.position.x<0):
			$Gun.set_flip_v(true)
		else:
			$Gun.set_flip_v(false)

func _on_area_2d_area_entered(area):
	if(area.is_in_group("enemy")):
		health-=area.damage
		if(health>0):
			$GettingHit.play()
			hud.update_health(health)
			var blood = player_hit_scene.instantiate()
			blood.position = self.position
			get_parent().add_child(blood)  
			
			var pushDir = self.position.direction_to(area.position)
			#self.position +=  pushDir * - 5
			
		else:  
			hud.update_health(health)
			emit_signal("player_died")
	elif(area.is_in_group("bullet_item")):
		$BulletPickup.play()
		bullets+=3
		hud.update_bullets(bullets)
		area.queue_free()
		


func _on_animation_player_animation_finished(anim_name):
	print(anim_name)
	if(anim_name=="getting_hit"):
		print('getting done hit')
