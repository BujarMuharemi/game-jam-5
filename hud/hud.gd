extends CanvasLayer

signal start_game
signal round_over
signal try_again_round

#TODO move to main script
@export var round_time = 60
var bullets = 240
# Called when the node enters the scene tree for the first time.
func _ready():
	_on_start_game_pressed() # Replace with function body.
	#$GameTimer.start()	
	#get_parent().get_node("Player").connect("bullet_shot",update_bullets(bullets-1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print($GameTimer.get_wait_time())
	pass
	
func update_bullets(bullets):
	$MarginContainer/Stats/Bullets.text = "Bullets: " + str(bullets)

func update_speed(bullets):
	$MarginContainer/Stats/Speed.text = "Speed: " + str(bullets)

func update_health(health):
	$MarginContainer/Stats/Health.text = "Health: " + str(health)

func _on_start_game_pressed():
	$StartGame.hide()
	start_game.emit()
	$GameTimer.start()	
	
	$TimeLeft.set_visible(true)
	
	$MarginContainer/Stats/Bullets.set_visible(true)
	
	

func _on_game_timer_timeout():
	if(round_time>0):
		round_time-=1
		$TimeLeft.text = "Time left: " + str(round_time)
	else:
		emit_signal("round_over")


func _on_try_again_pressed():
	emit_signal("try_again_round")
