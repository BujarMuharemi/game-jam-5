extends Area2D

@export var speed = 2
@export var damage = 2
@export var bulletHitSFX = 'res://enemy/bullet-hit2.mp3'
@export var explosion_scene: PackedScene
@export var bulletDrop: PackedScene
@export var health = 100

var gotHit = false
var sfx
signal bullet_hit

var rng = RandomNumberGenerator.new()
var wasHit = false
# Called when the node enters the scene tree for the first time.
func _ready():
	speed += rng.randf_range(-0.2, 0.5)
	$AnimationPlayer.play("enemy_walk")
	sfx = load(bulletHitSFX)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(get_parent().get_node("Player").position)
	#position.move_toward(get_parent().get_node("Player").position,100)
	position = position.move_toward(get_parent().get_node("Player").position,speed)
	#print($HitAudioStream.is_playing())
	
	if(!$HitAudioStream.is_playing() && gotHit && !$AnimationPlayer.is_playing()):		
		#if(rng.randf() > 0.2):
		var bullet = bulletDrop.instantiate()
		bullet.position = self.position
		get_node("/root/Main").add_child(bullet)
		self.queue_free()
		
		
	#get_node_or_null()
#func _physics_process(delta: float) -> void:
	

func _on_body_entered(body):	
	#print('@@',body)
	
	if(body.is_in_group("bullet") && !wasHit ):
		#$AudioStreamPlayer2D.stop()
		#$AudioStreamPlayer2D.set_stream(sfx)
		wasHit=true
		$CollisionShape2D.set_disabled(true)
		self.remove_from_group("enemy")
		
		$HitAudioStream.play()
		gotHit=true
		
		body.get_parent().hide()
		body.get_parent().queue_free()
		
		var explosion = explosion_scene.instantiate()
		explosion.position = self.position
		explosion.set_emitting(true)
		get_node("/root/Main").add_child(explosion)	
		
			
		
		#bullet_hit.emit()
		speed=0
		$AnimationPlayer.play("dying")
		#$AnimationPlayer.stop()
		#$CollisionShape2D.set_deferred("disabled", true)
		#print("removeing",body.get_parent().name)
		#$Sprite2D.hide()
		
		#self.queue_free()
