extends Node

var HUD_message

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	#$HUD.connect("start_game",game_started)
	$HUD.connect("round_over",round_over)
	$HUD.connect("try_again_round",restart_round)
	
	HUD_message = $HUD/Message
	
	$Player.connect("player_died",game_over)
	game_started()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func restart_round():
#	TODO: create game scene for starting game
	get_tree().reload_current_scene() 

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
	
	
func round_over():
	HUD_message.set_text('Round Over')
	HUD_message.set_visible(true)
	$HUD/StartGame.set_text("Next Round")
	$HUD/StartGame.set_visible(true)
	get_tree().paused = true

