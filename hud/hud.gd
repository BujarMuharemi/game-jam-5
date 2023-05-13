extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func update_bullets(bullets):
	$Bullets.text = str(bullets)
	



func _on_start_game_pressed():
	$StartGame.hide()
	start_game.emit()
