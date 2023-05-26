extends Node

var HUD_message

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	#$HUD.connect("start_game",game_started)
	$HUD.connect("round_over",round_over)
	$HUD.connect("try_again_round",restart_round)
	$HUD.connect("start_round",round_start)
	
	$HUD.update_bullets($Player.bullets)
	HUD_message = $HUD/Message   
	
	$Player.connect("player_died",game_over)
	game_started()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func restart_round():#	
	$Player.health=100
	$Player.bullets=5 
	$HUD.update_health(100)
	$HUD.update_bullets($Player.bullets)
	round_start($HUD.currentRound)
	$HUD.connect("try_again_round", restart_round, $HUD.currentRound)
		
	$HUD/TryAgain.set_visible(false)

func game_started():
	get_tree().paused = false
	print("game started")
	$Player.set_visible(true)

func game_over():
	HUD_message.set_text('Game Over')
	HUD_message.set_visible(true)
	#$HUD/TimeLeft.set_visible(false)
	$HUD/GameTimer.set_paused(true)
	$HUD/TryAgain.set_visible(true)
	get_tree().paused = true
	
	
func round_over(round):
	#print("round"+ str(round-1) + "over in main")
	$Player.health=100
	$Player.bullets=5 
	$HUD.update_health(100)
	$HUD.update_bullets($Player.bullets)
	HUD_message.set_text("Round " + str(round-1)+ " - Over - You won")
	HUD_message.set_visible(true)
	$HUD/NextRound.set_visible(true)
		
	get_tree().paused = true

func round_start(round):
	
	HUD_message.set_text("Round " + str(round))	
	$HUD/NextRound.set_visible(false)
	for node in get_tree().get_nodes_in_group("bullet_item"):		
		node.queue_free()
		
	for node in get_tree().get_nodes_in_group("enemy"):		
		node.queue_free()
	get_tree().paused = false
