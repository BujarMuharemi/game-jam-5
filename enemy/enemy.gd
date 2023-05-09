extends Area2D

signal bullet_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print(body)
	body.hide()
	hide()
	bullet_hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
