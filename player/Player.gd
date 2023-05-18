extends CharacterBody2D 

@export var speed = 600 
@export var bullet_scene: PackedScene
@export var bullets = 240
@export var health = 100

var screen_size
var hud
signal bullet_shot
signal player_died

func _ready():
	screen_size = get_viewport_rect().size
	#get_parent().get_node("Player").connect("bullet_shot",update_bullets(bullets-1))
	hud = get_parent().get_node("HUD")

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
		
	position += velocity * delta
		
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)
	
	# if(Input.is_action_just_pressed("left_click")):
	

#func _draw():	aaa
#	draw_line(A, B, Color(250,1,1), 3)
	
func _input(event):
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		
	if event is InputEventMouseButton and Input.is_action_just_pressed("left_click"):
		#print('playerPos',position)
		#print('mousePos',event.position)
		$GunShot.play()
		var diff = event.position - position
		diff =  position.direction_to(event.position)
		
		
		var bullet = bullet_scene.instantiate()
		bullet.position = position + diff*50#(diff.normalized/2) #event.position 
		var angle = bullet.position.angle_to(diff)
		#var dir = bullet.rotate(angle)
		#bullet.rotation=angle		
				
		var velocity = Vector2(diff.x , 0.0)
		#bullet.linear_velocity = event.position
		##bullet.add_constant_central_force(diff*500)
		#bullet.position.move_toward(event.position,1)
		bullet.direction = global_position.direction_to(get_global_mouse_position())
		
		get_parent().add_child(bullet) # adding it to the main scene
		#emit_signal("bullet_shot")
		bullets-=1
		hud.update_bullets(bullets)
		
	elif event is InputEventMouseMotion:
		#TODO: add this code to when the player is also moving
		var diff = event.position - position
		diff =  position.direction_to(event.position)
		$Gun.position = diff*50
		#print("Mouse Click/Unclick at: ", event.position)

func _on_area_2d_area_entered(area):
	if(area.is_in_group("enemy")):
		health-=area.damage
		if(health>=0):
			hud.update_health(health)
		else:
			emit_signal("player_died")
		
