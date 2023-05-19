extends Area2D

@export var speed = 2
@export var damage = 2
@export var bulletHitSFX = 'res://enemy/bullet-hit2.mp3'
var sfx
signal bullet_hit

var rng = RandomNumberGenerator.new()

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

#func _physics_process(delta: float) -> void:
	

func _on_body_entered(body):	
	#print('@@',body)
	
	if(body.is_in_group("bullet")):
		$AudioStreamPlayer2D.stop()
		$AudioStreamPlayer2D.set_stream(sfx)
		$AudioStreamPlayer2D.play()
		$AudioStreamPlayer2D.has_stream_playback()
		body.get_parent().hide()
		
		bullet_hit.emit()
		#$CollisionShape2D.set_deferred("disabled", true)
		print("removeing",body.get_parent().name)
		#self.hide()
		#self.queue_free()
