extends CanvasLayer

signal start_game
signal round_over(round_number)
signal try_again_round
signal start_round(round_number)

var currentRound = 1

#TODO move to main script
@export var round_time = 60
#@export var rounds = []
var bullets = 240
# Called when the node enters the scene tree for the first time.
func _ready():
	_on_start_game_pressed() # Replace with function body.
	$Message.text = "Round "+ str(currentRound)
	$Message.set_visible(true)
	
	#$GameTimer.start()	
	#get_parent().get_node("Player").connect("bullet_shot",update_bullets(bullets-1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print($GameTimer.get_wait_time())
	#$TimeLeft.text = "Time left: " + str($GameTimer.get_wait_time())
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
		$GameTimer.stop()
		currentRound+=1
		emit_signal("round_over",currentRound)


func _on_try_again_pressed():
	$GameTimer.set_paused(false)
	round_time=60
	$GameTimer.start()
	emit_signal("try_again_round")

func _on_next_round_pressed():
	emit_signal("start_round",currentRound)
	$GameTimer.set_paused(false)
	round_time=60
	$GameTimer.start()
	#GameTimer.start()
	print("starting Round %s",currentRound)
