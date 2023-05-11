extends Area2D

signal bullet_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.move_toward(get_parent().get_node("Player").position,100)

func _on_body_entered(body):	
	body.get_parent().hide()	
	hide()
	bullet_hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
