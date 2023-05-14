extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	#get_tree().paused = true
	$HUD.connect("start_game",game_started)
	$HUD.connect("round_over",round_over)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_started():
	#get_tree().paused = true
	print("game started")
	
func round_over():
	print("round over")
